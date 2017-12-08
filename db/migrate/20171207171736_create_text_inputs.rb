class CreateTextInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :text_inputs do |t|
      t.references :query, index:true, foreign_key:true, null:false
      t.text :input_text

      t.timestamps
    end
  end
end
