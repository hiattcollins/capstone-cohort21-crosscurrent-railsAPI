class Query < ApplicationRecord

  belongs_to :user
  has_many :text_inputs
  has_many :song_results

  validates_presence_of :user_id
end
