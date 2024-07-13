class ProductsController < ApplicationController
  before_action :authorize
  before_action :load_product, only: [:update]

  def create
    @product = Product.create(product_params)
    @product.user_id = current_user.id

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.erros, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :accepted
    else
      render json: @product.erros, status: :unprocessable_entity
    end
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
