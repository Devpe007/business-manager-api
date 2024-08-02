class PurchaseOrdersController < ApplicationController
  before_action :load_purchase_order, only: %i[show update destroy]

  def show
    render json: @purchase_order
  end

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

  def update
    if @purchase_order.update(purchase_order_params)
      render json: @purchase_order, status: :accepted
    else
      render json: @purchase_order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase_order.destroy

    render json: { message: 'Purchase order destroyed successfully.' }, status: :accepted
  end

  private

  def load_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  rescue StandardError
    render json: { message: 'This purchase order does not exists.' }, status: :bad_request
  end

  def purchase_order_params
    params.permit(:product_id, :quantity, :description)
  end
end
