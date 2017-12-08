class User < ApplicationRecord

  has_many :queries

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name

end
