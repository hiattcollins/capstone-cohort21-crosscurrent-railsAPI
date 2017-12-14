class SongArchivesController < ApplicationController

  # index, show, new, edit, create, update and destroy

  def index
    @song_archives = SongArchive.all
    render json: @song_archives
  end

  def query_to_archive
    @sadness = song_archive_params["sadness"]
    @joy = song_archive_params["joy"]
    @fear = song_archive_params["fear"]
    @disgust = song_archive_params["disgust"]
    @anger = song_archive_params["anger"]
    # @query_to_archive = SongArchive.find_by_sql('SELECT song, artist, (ABS(sadness - #{@sadness}) + ABS(joy - #{@joy}) + ABS(fear - #{@fear}) + ABS(disgust - #{@disgust}) + ABS(anger - #{@anger})) AS difference FROM song_archives ORDER BY difference ASC')
    @query_to_archive = SongArchive.select("id, song, artist, (ABS(sadness - '#{@sadness}') + ABS(joy - '#{@joy}') + ABS(fear - '#{@fear}') + ABS(disgust - '#{@disgust}') + ABS(anger - '#{@anger}')) AS difference").order('difference ASC')
    # @query_to_archive = SongArchive.select('song, artist, (ABS(sadness - ?) + ABS(joy - #{@joy}) + ABS(fear - #{@fear}) + ABS(disgust - #{@disgust}) + ABS(anger - #{@anger})) AS difference'), #{@sadness}
    render json: @query_to_archive
  end

  private

    def song_archive_params
      params.require(:song_archive).permit(:sadness, :joy, :fear, :disgust, :anger)
    end

end
