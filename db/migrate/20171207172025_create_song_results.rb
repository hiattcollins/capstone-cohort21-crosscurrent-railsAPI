class CreateSongResults < ActiveRecord::Migration[5.1]
  def change
    create_table :song_results do |t|
      t.references :query, index:true, foreign_key:true, null:false
      t.text :artist
      t.text :song
      t.text :album
      t.text :ISRC

      t.timestamps
    end
  end
end
