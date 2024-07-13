class ProductsController < ApplicationController
  before_action :authorize

  def create
    @product = Product.create(product_params)
    @product.user_id = current_user.id

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.erros, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.permit(:name, :price, :cost, :quantity, :inventory)
  end
end
