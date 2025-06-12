class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @random_properties = Property.order("RANDOM()").limit(4)

    if user_signed_in?
      @user_bookings = current_user.bookings
      @user_properties = current_user.properties.includes(:bookings)
    end

  end
end
