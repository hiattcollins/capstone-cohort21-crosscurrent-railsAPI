class SongArchivesController < ApplicationController

  # index, show, new, edit, create, update and destroy

  def index
    @song_archives = SongArchives.new
    render json: @song_archives
  end


end
