class HomeController < ApplicationController
  def index
    @bookings = Booking.all
    @properties = Property.all
  end
end
