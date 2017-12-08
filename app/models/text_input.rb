class TextInput < ApplicationRecord

  belongs_to :query

  validates_presence_of :query_id, :input_text

end
