class SongResultsController < ApplicationController

  # index, show, new, edit, create, update and destroy

  def index
    @song_results = SongResult.all
    render :json @song_results
  end

  def show
    set_song_result
    render :json @song_result
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

    def song_result_params
      params.require(:song_result).permit(:query_id, :artist, :song_name, :album, :ISRC)
    end
end
