# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]
    respond_to :json

    private

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
    end

    def respond_with(_resource, _opts = {})
      render json: { message: "You've logged in sucessfully.", user: current_user }, status: :ok
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
