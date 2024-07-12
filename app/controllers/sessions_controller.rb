class SessionsController < ApplicationController
  skip_before_action :authorize

  def authenticate
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = encode_token(user_id: user.id, email: user.email)

      render json: user.as_json(except: %i[password_digest created_at updated_at]).merge({ token: }), status: :ok
    else
      render json: { error: 'An Error Happened.' }
    end
  end
end
