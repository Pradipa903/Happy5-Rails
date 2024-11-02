class CarsController < ApplicationController
  before_action :set_brand
  before_action :set_brand_car, only: [:show, :update, :destroy]

  # GET /brands/:brand_id/cars
  def index
    json_response(@brand.cars)
  end

  # GET /brands/:brand_id/cars/:id
  def show
    json_response(@car)
  end

  # POST /brands/:brand_id/cars
  def create
    @brand.cars.create!(car_params)
    json_response(@brand, :created)
  end

  # PUT /brands/:brand_id/cars/:id
  def update
    @car.update(car_params)
    head :no_content
  end

  # DELETE /brands/:brand_id/cars/:id
  def destroy
    @car.destroy
    head :no_content
  end

  private

  def car_params
    params.permit(:name, :car_type, :is_used, :release_year)
  end

  def set_brand
    @brand = Brand.find(params[:brand_id])
  end

  def set_brand_car
    @car = @brand.cars.find_by!(id: params[:id]) if @brand
  end
end
