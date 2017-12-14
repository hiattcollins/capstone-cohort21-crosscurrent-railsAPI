class AuthenticationController < ApplicationController

  skip_before_action :authenticate_request

  def register
    user = User.new(email: params[:email], password: params[:password], first_name: params[:first_name], last_name: params[:last_name])

    if user.save
        authenticate
      else
        render json: user.errors, staus: :unprocessable_entity
    end
  end

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
