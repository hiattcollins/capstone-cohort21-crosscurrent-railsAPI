class QueriesController < ApplicationController

  def index
    @queries = Query.all
    render json: @queries
  end

  def text_query

    @user_id = query_params["user_id"]
    @query = Query.new(:user_id => @user_id)

    @query_id = nil

    if @query.save
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

    p "@resulting_songs_from_archive:"
    p @resulting_songs_from_archive
    # @song_results_array = JSON.parse(@resulting_songs_from_archive)

    # p @resulting_songs_from_archive
    # puts @resulting_songs_from_archive


    @song_results_to_save = []

    @resulting_songs_from_archive.each do |song|
      song_hash = Hash.new
      song_hash["query_id"] = @query_id
      song_hash["artist"] = song["artist"].titleize
      song_hash["song"] = song["song"].titleize
      song_hash["difference"] = song["difference"]
      @song_results_to_save << song_hash
    end

    @saved_songs = SongResult.create(@song_results_to_save)

    @song_results_to_show = SongResult.where(query_id: @query_id)

    render json: @song_results_to_show #@resulting_songs_from_archive

  end

  def get_by_user
    @user_id = query_params["user_id"]
    @query_results_by_user = Query.joins(:text_inputs, :song_results).where(:user_id => @user_id).select("queries.id, queries.user_id, text_inputs.input_text, song_results.difference, song_results.artist, song_results.song")
    @query_results_array = Array.new

    # Create array to hold hashes for each search
    # Each hash will hold the search id, the input text, and the resulting songs
    @queries_with_songs = Array.new

    @query_results_by_user.each do |query_result|

      if @queries_with_songs[0] == nil
        query_hash = {
                      :id => query_result[:id],
                      :input_text => query_result[:input_text],
                      # :song_results => [query_result[:song_results]]
                      :song_results => [{:difference => query_result[:difference], :artist => query_result[:artist], :song => query_result[:song]}]
                    }
        @queries_with_songs.push(query_hash)
      else
        query_result_id = query_result[:id]
        @existing_query_index = @queries_with_songs.find_index{|query| query[:id] == query_result[:id]}
        if @existing_query_index
          @queries_with_songs[@existing_query_index][:song_results] << {:difference => query_result[:difference], :artist => query_result[:artist], :song => query_result[:song]}  #query_result[:song_results]
        else
          query_hash = {
                      :id => query_result[:id],
                      :input_text => query_result[:input_text],
                      :song_results => [{:difference => query_result[:difference], :artist => query_result[:artist], :song => query_result[:song]}]
                      }
          @queries_with_songs << query_hash
        end
      end
    end
    render json: @queries_with_songs
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

  def update
    set_query
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
