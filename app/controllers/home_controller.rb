class HomeController < ApplicationController
  def index
    @random_properties = Property.order("RANDOM()").limit(4)

    if user_signed_in?
      @user_properties = current_user.properties.includes(:bookings)
      @user_bookings = current_user.bookings.includes(:property)
      @user_property_bookings = Booking.joins(:property).where(properties: { user_id: current_user.id })
    end

  end
end
