class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]

  def index
    products = Product.order(:name)
    render json: products
  end

  def show
    render json: @product
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product, status: :created, location: product
    else
      render_validation_errors(product)
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render_validation_errors(@product)
    end
  end

  def destroy
    @product.destroy!
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params.expect(:id))
  end

  def product_params
    params.require(:product).permit(:name, :sku, :price, :stock)
  end
end
