class EventsController < ApplicationController
  # Je visualise tous les évènements
  # skip_before_action :authenticate_user!, only: [:index, :show ]
  def index
    if params[:filter]
      @events = filter
    else
      @events = Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def filter
    filtered_events = []
    params[:filter][:tags].each do |category|
      Event.all.each do |event|
        filtered_events << event if event.tags.include?(category)
      end
    end
    filtered_events.uniq
  end

  def params_event
    require.params(:event).permit(:title, :chapeau, :description, :background_image)
  end
end
