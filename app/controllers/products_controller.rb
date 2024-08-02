class ProductsController < ApplicationController
  before_action :authorize
  before_action :load_product, only: %i[show update destroy]

  def index
    @products = Product.where(user_id: current_user.id)

    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @product = Product.create(product_params)
    @product.user_id = current_user.id

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :accepted
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    render json: { message: 'Product destroyed successfully.' }, status: :accepted
  end

  private

  def load_product
    @product = Product.find(params[:id])
  rescue StandardError
    render json: { message: 'This product does not exists.' }, status: :bad_request
  end

  def product_params
    params.permit(:name, :price, :cost, :quantity, :inventory)
  end
end
