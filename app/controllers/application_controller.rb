# frozen_string_literal: true

class ApplicationController < ActionController::API
  def healthz
    render json: { status: 'ok' }
  end

  def user_must_be_proprietor
    return unless current_user && !current_user.is_proprietor

    render json: { error: 'Only proprietors can perform this action.' }, status: :unauthorized
  end
end
