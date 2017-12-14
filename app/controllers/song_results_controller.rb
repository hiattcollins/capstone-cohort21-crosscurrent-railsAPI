class SongResultsController < ApplicationController

  # index, show, new, edit, create, update and destroy

  def index
    @song_results = SongResult.all
    render json: @song_results
  end

  def multi_insert
    song_input = '[
    {
        "query_id": 2,
        "artist": "mark ronson featuring bruno mars",
        "song_name": "uptown funk"
    },
    {
        "query_id": 2,
        "artist": "walk the moon",
        "song_name": "shut up and dance"
    },
    {
        "query_id": 2,
        "artist": "fetty wap",
        "song_name": "trap queen"
    }]'

    test_multi = JSON.parse(song_input)

    @multi_result = SongResult.create(test_multi)

  end


  def show
    set_song_result
    render json: @song_result
  end

  def create
    @song_result = SongResult.new(song_result_params)

    if @song_result.save
        render json: @song_result, status: :created, location: @song_result
      else
        render json: @song_result.errors, staus: :unprocessable_entity
    end
  end

  def update
    set_song_result
    if @song_result.update(song_result_params)
      redirect_to @song_result
    else
      render 'edit'
    end
  end

  def destroy
    set_song_result
    @song_result.destroy
  end

  private

  def set_song_result
      @song_result = SongResult.find(params[:id])
    end

    # Note: db will also accept :album and :ISRC, but current data lacks those parameters
    def song_result_params
      params.require(:song_result).permit(:query_id, :artist, :song_name, :album, :ISRC)
    end
end
