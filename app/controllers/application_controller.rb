class ApplicationController < ActionController::API
  before_action :authorize

  attr_reader :current_user

  def authorize
    @headers = request.headers
    if @headers['Authorization'].present?
      token = @headers['Authorization'].split(' ').last

      decoded_token = decode(token)

      @current_user = User.find_by(id: decoded_token[:user_id])

      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    else
      render json: { error: 'Not Authorized' }, status: 401
    end
  end

  private

  def encode_token(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i

    JWT.encode(payload, '<%= ENV["JWT_SECRET"] %>')
  end

  def decode(token)
    body = JWT.decode(token, '<%= ENV["JWT_SECRET"] %>')[0]
    HashWithIndifferentAccess.new body
  rescue StandardError
    nil
  end
end
