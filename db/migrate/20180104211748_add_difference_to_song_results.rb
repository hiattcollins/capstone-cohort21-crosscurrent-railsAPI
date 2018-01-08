class AddDifferenceToSongResults < ActiveRecord::Migration[5.1]
  def change
    add_column :song_results, :difference, :float, after: :ISRC
  end
end
