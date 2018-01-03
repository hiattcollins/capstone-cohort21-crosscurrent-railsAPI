class QueriesController < ApplicationController

  # index, show, new, edit, create, update and destroy

  def index
    @queries = Query.all
    render json: @queries
  end

  def text_query

    @user_id = query_params["user_id"]
    @query = Query.new(:user_id => @user_id)

    @query_id = nil

    if @query.save
        # render json: @query, status: :created, location: @query
        # query_hash = JSON.parse(@query)
        @query_id = @query["id"]
      else
        render json: @query.errors, staus: :unprocessable_entity
    end

    @input_text = query_params["input_text"]
    @text_input_from_query = TextInput.new(:query_id => @query_id, :input_text => @input_text)
    @text_input_from_query.save


    @test_results = Watson.watson_query(@input_text)
    @sentiment = @test_results["emotion"]["document"]["emotion"]
    # render json: @sentiment

    @sadness = @sentiment["sadness"]
    @joy = @sentiment["joy"]
    @fear = @sentiment["fear"]
    @disgust = @sentiment["disgust"]
    @anger = @sentiment["anger"]
    # @query_to_archive = SongArchive.find_by_sql('SELECT song, artist, (ABS(sadness - #{@sadness}) + ABS(joy - #{@joy}) + ABS(fear - #{@fear}) + ABS(disgust - #{@disgust}) + ABS(anger - #{@anger})) AS difference FROM song_archives ORDER BY difference ASC')
    @resulting_songs_from_archive = SongArchive.select("id, song, artist, (ABS(sadness - '#{@sadness}') + ABS(joy - '#{@joy}') + ABS(fear - '#{@fear}') + ABS(disgust - '#{@disgust}') + ABS(anger - '#{@anger}')) AS difference").order('difference ASC').limit(5)

    # @song_results_array = JSON.parse(@resulting_songs_from_archive)

    # p @resulting_songs_from_archive
    # puts @resulting_songs_from_archive


    @song_results_to_save = []

    @resulting_songs_from_archive.each do |song|
      song_hash = Hash.new
      song_hash["query_id"] = @query_id
      song_hash["artist"] = song["artist"]
      song_hash["song"] = song["song"]
      @song_results_to_save << song_hash
    end

    @saved_songs = SongResult.create(@song_results_to_save)

    render json: @resulting_songs_from_archive

  end

  def get_by_user
    @user_id = query_params["user_id"]
    # @user_query = Query.find_by_sql('SELECT queries.id, queries.user_id, text_inputs.input_text, song_results.artist, song_results.song FROM queries LEFT JOIN text_inputs ON queries.id == text_inputs.query_id LEFT JOIN song_results ON queries.id == song_results.query_id WHERE queries.user_id == 6')
    # @user_query = Query.joins(:song_results).where('queries.user_id = "#{@user_id}"')
    @user_query = Query.joins(:text_inputs, :song_results).where(:user_id => @user_id).select("queries.id, queries.user_id, text_inputs.input_text, song_results.artist, song_results.song")  #.group("queries.id")




    render json: @user_query
  end

  def show
    set_query
    render json: @query
  end

  def create
    @user_id = query_params["user_id"]
    @query = Query.new(:user_id => @user_id)

    if @query.save
        render json: @query, status: :created, location: @query
      else
        render json: @query.errors, staus: :unprocessable_entity
    end
  end


  #### #check on this
  def update
    set_query
    # @query = Query.new(:user_id => @user_id)
    if @query.update(query_params)
      redirect_to @query
    else
      render 'edit'
    end
  end

  def destroy
    set_query
    @query.destroy
  end

  private

    def set_query
      @query = Query.find(params[:id])
    end

    def query_params
      params.require(:query).permit(:user_id, :input_text)
    end

end
