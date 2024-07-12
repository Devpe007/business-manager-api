class CustomersController < ApplicationController
  before_action :authorize

  def create
    @customer = Customer.create(customer_params)
    @customer.user_id = current_user.id

    if @customer.save
      render json: @customer, status: :created
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.permit(:name, :email, :mobile_number, :address, :description)
  end
end
