# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]
    respond_to :json

    def create
      user = User.find_by(email: params[:user][:email])

      if user && user.confirmed_at.nil?
        render json: { message: 'Please confirm your email before logging in.' }, status: :unauthorized
      elsif user.nil?
        render json: { message: 'The user does not exist' }, status: :unauthorized
      else
        super
      end
    end

    private

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
    end

    def respond_with(_resource, _opts = {})
      render json: { message: "You've logged in sucessfully.", user: UserBluePrint.render(current_user) }, status: :ok
    end

    def respond_to_on_destroy
      log_out_success && return unless current_user

      log_out_failure
    end

    def log_out_success
      head :no_content
    end

    def log_out_failure
      render json: { message: 'No active session exists.' }, status: :unauthorized
    end
  end
end
