class Event < ApplicationRecord
  has_many :interests
  has_many :users, through: :interests
  has_many :reviews, through: :interests
  has_one :affluence, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # CATEGORY = ["Peinture", "Art contemporain", "Théâtre"]
end
