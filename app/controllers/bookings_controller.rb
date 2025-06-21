class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.includes(:property)

  end

  def show
    if @booking.user == current_user
      render "bookings/show"
    else
      redirect_to bookings_path, alert: "You are not authorized to view this booking."
    end
  end

  def new
    @booking = Booking.new
  end

  def create
    @property = Property.find(params[:property_id])
    @booking = Booking.new(booking_params)
    @booking.property = @property
    @booking.user = current_user

    if @booking.save
      redirect_to @property, notice: "Booking pending approval!"
    else
      render "properties/show", status: :unprocessable_entity
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

  require 'debug'
  def destroy
    if @booking.user_id || @booking.property.user_id == current_user.id
      @booking.destroy
      redirect_to root_path, alert: "Booking canceled successfully."
    else
      redirect_to root_path, alert: "You are not authorized to cancel this booking."
    end
  end

  def update_status
  @booking = Booking.find(params[:id])
  if @booking.update(booking_status: params[:booking_status])
    render json: { booking_status: @booking.booking_status }
  else
    render json: { error: "Failed to update status" }, status: :unprocessable_entity
  end
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
