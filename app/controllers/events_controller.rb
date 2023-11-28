class EventsController < ApplicationController

  # Je visualise tous les évènements
  def index
    @events = Event.all
  end
end
