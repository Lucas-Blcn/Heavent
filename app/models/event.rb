class Event < ApplicationRecord
  has_many :interests
  has_many :users, through: :interests
  has_many :reviews, through: :interests
  has_one :affluence, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def formatted_zip_code
    "#{zip_code[-2..-1]}e"
  end
  
end
