# frozen_string_literal: true

class ApplicationController < ActionController::API
  def healthz
    render json: { status: 'ok' }
  end
end
