class UsersController < ApplicationController
  before_action :find_by_email, only: [:create]

  def create
    @user = User.create(user_params)

    if @user.save
      render json: @user.as_json(except: [:password_digest]), status: :created
    else
      render json: { error: 'erro ao criar usuario', messages: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def find_by_email
    @user = User.find_by(email: user_params[:email])

    return unless @user

    render json: { message: 'This user already exists' }, status: :bad_request
  end

  def user_params
    params.permit(:name, :email, :password)
  end
end
