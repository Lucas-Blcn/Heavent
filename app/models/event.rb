class Event < ApplicationRecord
  has_many :interests
  has_many :users, through: :interests
  has_many :reviews, through: :interests
  has_one :affluence, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def formatted_zip_code
    # "#{zip_code[-2..-1]}<sup>e</sup>".html_safe
    if zip_code[-2..-1][0] == '0'
          arrondissement = case zip_code[-2..-1][1]
            when '1'
            "#{zip_code[-1]}<sup>er</sup>".html_safe
            when '2'
            "#{zip_code[-1]}<sup>nd</sup>".html_safe
            else
            "#{zip_code[-1]}<sup>ème</sup>".html_safe
          end
      else
      "#{zip_code[-2..-1]}<sup>ème</sup>".html_safe
    end
  end

end
