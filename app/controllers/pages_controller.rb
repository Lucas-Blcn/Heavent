class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]
  def home
  end

  def map
    @events = Event.all

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude
      }
    end
  end
end
