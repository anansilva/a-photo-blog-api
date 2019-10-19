class AuthenticationsController < ApplicationController 
  skip_before_action :authorize_request

  def login
    if find_user&.authenticate(login_params[:password])
      token = Services::Authentications::JsonWebToken.encode(
        { user_id: find_user.id, user_email: find_user.email },
        expiring_date
      )

      render json: { token: token,
                     exp: expiring_date,
                     user_id: find_user.id,
                     user_email: find_user.email },
             status: :ok
    else
      render status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def payload(user_id, user_email)
    { user_id: user_id, user_email: user_email }
  end

  def expiring_date
    @expiring_date ||= 24.hours.from_now
  end

  def find_user
    @find_user ||= User.find_by_email(login_params[:email])
  end
end
