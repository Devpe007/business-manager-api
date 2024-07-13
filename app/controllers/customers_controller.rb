class CustomersController < ApplicationController
  before_action :authorize
  before_action :load_customer, only: %i[show update]

  def index
    @customers = Customer.where(user_id: current_user.id)

    render json: @customers
  end

  def show
    render json: @customer
  end

  def create
    @customer = Customer.create(customer_params)
    @customer.user_id = current_user.id

    if @customer.save
      render json: @customer, status: :created
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      render json: @customer, status: :accepted
    else
      render json: @customer.erros, status: :unprocessable_entity
    end
  end

  private

  def load_customer
    @customer = Customer.find(params[:id])
  rescue StandardError
    render json: { error: 'This user not exits.' }, status: :bad_request
  end

  def customer_params
    params.permit(:name, :email, :mobile_number, :address, :description)
  end
end
