class InterestsController < ApplicationController
  before_action :authenticate_user!

  DAYS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

  def index
    @interests = current_user.interests.where(liked: true)
    @events = @interests.map(&:event)

    @today = DAYS.index(Date.today.strftime("%a"))
    @hour = 12
  end

  def favorite
    @event = Event.find(params[:id])

    if current_user.has_favorited?(@event)

      # unfav event
      current_user.interests.find_by(event: @event).destroy
      render json: { favorite: false }
    else
      # fav event
      Interest.create(user_id: current_user.id, event: @event, liked: true)
      render json: { favorite: true }
    end
  end
end
