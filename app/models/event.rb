class Event < ApplicationRecord
  has_many :interests
  has_many :users, through: :interests
  has_many :reviews, through: :interests

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
