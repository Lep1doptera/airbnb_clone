class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(
      :check_in_date,
      :check_out_date,
      :number_of_guests,
      :booking_status,
      :property_id
    )
  end
end
