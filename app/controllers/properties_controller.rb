class PropertiesController < ApplicationController
  def create
    @property = Property.find(params[:id])
    @booking = @property.bookings.build(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to @property
    else
      redirect_to @property, alert: "Booking failed"
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:check_in_date, :check_out_date, :booking_status, :number_of_guests)
  end
end
