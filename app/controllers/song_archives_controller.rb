class SongArchivesController < ApplicationController

  # index, show, new, edit, create, update and destroy

  def index
    @song_archives = SongArchive.all
    render json: @song_archives
  end


end
