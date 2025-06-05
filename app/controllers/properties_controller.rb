class PropertiesController < ApplicationController
  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
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
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to listings_path
  end

  private

  def property_params
    params.require(:property).permit(:property_address, :number_of_guests, :description, :price_per_night, :property_image_url)
  end
end
