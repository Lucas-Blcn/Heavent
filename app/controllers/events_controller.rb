class EventsController < ApplicationController
  # Je visualise tous les évènements
  # skip_before_action :authenticate_user!, only: [:index, :show ]
  def index
    if params[:filter]
      # itére sur les params que je recois
      # pour chacun des tags
      # si event.category include le tag alors je le sélectionne
      # après le each je viens .uniq sur mon array
      # ton nouveau @events
      # @events = Event.where()
      @events = filter
    else
      @events = Event.all
    end
    # @category = ["Peinture", "Art contemporain", "Théâtre"]
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
