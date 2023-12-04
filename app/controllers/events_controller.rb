class EventsController < ApplicationController
  # Je visualise tous les évènements
  # skip_before_action :authenticate_user!, only: [:index, :show ]
  def index
    @events = Event.all
    @events = @events.where(type_of_price: "gratuit") if params[:free] == "true"
    @events = filter if params[:query]
    # if params[:query] && params[:free] == "false"
    #   filter
    # elsif params[:free] == "true"
    #   @events = Event.where(type_of_price: "gratuit")
    # else
    #   @events = Event.all
    # end

    @events = Event.all if @events == []
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
    filters = params[:query].split(",")
    @events = @events.select do |event|
      event.tags.any? { |x| filters.include?(x) }
    end.uniq
  end

  def params_event
    require.params(:event).permit(:title, :chapeau, :description, :background_image, :price_details)
  end
end
