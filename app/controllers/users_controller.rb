class UsersController < ApplicationController
  skip_before_action :authorize, only: [:create]
  before_action :already_exists?, only: [:create]

  def create
    @user = User.create(user_params)

    if @user.save
      render json: @user.as_json(except: [:password_digest]), status: :created
    else
      render json: { error: 'Error to create user.', messages: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def already_exists?
    @user = User.find_by(email: user_params[:email])

    return unless @user

    render json: { message: 'This user already exists.' }, status: :bad_request
  end

  def user_params
    params.permit(:name, :email, :password)
  end
end
