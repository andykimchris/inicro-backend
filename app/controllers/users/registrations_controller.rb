# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_params, only: [:create]

    respond_to :json

    private

    def configure_permitted_params
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: %i[email password password_confirmation is_proprietor is_occupant])
    end

    def respond_with(resource, _opts = {})
      register_success_registration && return if request.method == 'POST' && resource.persisted?

      register_success_deletion if request.method == 'DELETE'

      register_failed
    end

    def register_success_registration
      render json: { message: "You've signed up successfully." }, status: :created
    end

    def register_success_deletion
      head :no_content
    end

    def register_failed
      render json: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" },
             status: :unprocessable_entity
    end
  end
end
