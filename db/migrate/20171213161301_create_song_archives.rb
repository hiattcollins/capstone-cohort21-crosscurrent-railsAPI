class CreateSongArchives < ActiveRecord::Migration[5.1]
  def change
    create_table :song_archives do |t|
      t.text :song
      t.text :artist
      t.integer :year
      t.text :lyrics
      t.float :sadness
      t.float :joy
      t.float :fear
      t.float :disgust
      t.float :anger

      t.timestamps
    end
  end
end
