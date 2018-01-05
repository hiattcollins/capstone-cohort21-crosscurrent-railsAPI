class Query < ApplicationRecord

  belongs_to :user
  has_many :text_inputs, dependent: :destroy
  has_many :song_results, dependent: :destroy

  validates_presence_of :user_id
end
