class EventsController < ApplicationController
  DAYS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
  # Je visualise tous les évènements
  # skip_before_action :authenticate_user!, only: [:index, :show ]
  def index
    @empty = false
    @events = Event.all
    @events = @events.where(type_of_price: "gratuit") if params[:free] == "true"

    @today = DAYS.index(Date.today.strftime("%a"))
    # @hour = Time.now.hour
    @hour = 12

    @events = filter if params[:query] && params[:query] != ""
    @empty = true if params[:free] == "true" && @events == []
    @events = Event.all if @events == []
    respond_to do |format|
      format.html
      format.text { render partial: "events/list", locals: { events: @events }, formats: [:html] }
    end
  end

  def show
    @events = Event.all
    @event = Event.find(params[:id])
    @hour = Time.now.hour
  end

  private

  def filter
    filters = params[:query].split(",")
    @events = @events.select do |event|
      event.tags.any? { |tag| filters.include?(tag) }
    end.uniq
  end

  def params_event
    require.params(:event).permit(:title, :chapeau, :description, :background_image, :price_details, :zip_code)
  end
end
