class AuthenticationsController < ApplicationController
  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      render status: :ok
    else
      render status: :unauthorized
    end        
  end
end
