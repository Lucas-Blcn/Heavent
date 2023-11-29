class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]
  def home
  end

  def landing
  end
  
  def map
  @events = Event.all

  @markers = @events.geocoded.map do |event|
    {
      lat: event.latitude,
      lng: event.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { event: }),
      marker_html: render_to_string(partial: "marker", locals: { event: })
    }
  end
 
end
