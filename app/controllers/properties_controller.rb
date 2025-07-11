class PropertiesController < ApplicationController
  def index
    @properties = Property.all
     if params[:query].present?
      @properties = @properties.where("property_address ILIKE ?", "%#{params[:query]}%")
    end
    @markers = @properties.geocoded.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {property: property})
      }
    end
  end

  def new
    @property = Property.new
    @booking = Booking.new
  end

  def create
    @property = Property.new(property_params)
    @property.user = current_user

    if @property.save
      redirect_to @property
    else
      render :new
    end
  end

  def show
    @property = Property.find(params[:id])
    @booking = Booking.new

    @markers = [{
      lat: @property.latitude,
      lng: @property.longitude
    }]
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to root_path
  end

  private

  def property_params
    params.require(:property).permit(:property_address, :number_of_guests, :description, :price_per_night, :property_image_url)
  end
end
