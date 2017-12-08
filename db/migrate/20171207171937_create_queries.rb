class CreateQueries < ActiveRecord::Migration[5.1]
  def change
    create_table :queries do |t|
      t.references :user, index:true, foreign_key:true, null:false

      t.timestamps
    end
  end
end
