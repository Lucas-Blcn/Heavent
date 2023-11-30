class EventsController < ApplicationController
  # Je visualise tous les évènements
  # skip_before_action :authenticate_user!, only: [:index, :show ]
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def params_event
    require.params(:event).permit(:title, :chapeau, :description, :background_image)
  end
end
