class Event < ApplicationRecord
  has_many :interests
  has_many :users, through: :interests
  has_many :reviews, through: :interests
end
