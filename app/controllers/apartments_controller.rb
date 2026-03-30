class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[ show update destroy ]

  def index
    apartments = Apartment.order(:name)
    render json: apartments
  end

  def show
    render json: @apartment, include: :invoices
  end

  def create
    apartment = Apartment.new(apartment_params)

    if apartment.save
      render json: apartment, status: :created, location: apartment
    else
      render_validation_errors(apartment)
    end
  end

  def update
    if @apartment.update(apartment_params)
      render json: @apartment
    else
      render_validation_errors(@apartment)
    end
  end

  def destroy
    @apartment.destroy!
    head :no_content
  end

  private

  def set_apartment
    @apartment = Apartment.find(params.expect(:id))
  end

  def apartment_params
    params.expect(apartment: [ :name, :email, :phone ])
  end
end
