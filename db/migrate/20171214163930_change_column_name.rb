class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :song_results, :song_name, :song
  end
end
