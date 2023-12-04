class EventsController < ApplicationController
  # Je visualise tous les évènements
  # skip_before_action :authenticate_user!, only: [:index, :show ]
  def index
    if params[:query]
      filters = params[:query].split(",")
      @events = Event.all.select do |event|
        event.tags.any? { |x| filters.include?(x) }
      end.uniq
    else
      @events = Event.all
    end

    respond_to do |format|
      format.html
      format.text { render partial: "events/list", locals: { events: @events }, formats: [:html] }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def filter
  end

  def params_event
    require.params(:event).permit(:title, :chapeau, :description, :background_image)
  end
end
