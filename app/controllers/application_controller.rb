class ApplicationController < ActionController::API
  before_action :authorize_request

  attr_reader :current_user

  def authorize_request
    token = request.headers[:HTTP_TOKEN]
    begin
      decoded = Services::Authentications::JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
