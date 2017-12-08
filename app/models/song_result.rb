class SongResult < ApplicationRecord

  belongs_to :query

  validates_presence_of :query_id, :artist, :song_name, :album

end
