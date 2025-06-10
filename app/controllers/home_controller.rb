class HomeController < ApplicationController
  def index
    @bookings = Booking.all
    @properties = Property.all
    @random_properties = Property.order("RANDOM()").limit(4)
  end
end
