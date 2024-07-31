class PurchaseOrdersController < ApplicationController
  def create
    @purchase_order = PurchaseOrder.create(purchase_order_params)
    @purchase_order.user_id = current_user.id
    @purchase_order.customer_id = params[:customer_id]

    if @purchase_order.save
      render json: @purchase_order, status: :created
    else
      render json: @purchase_order.errors, status: :unprocessable_entity
    end
  end

  private

  def purchase_order_params
    params.permit(:product_id, :quantity, :description)
  end
end
