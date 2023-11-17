# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations' do
  let(:proprietor_user) { build_proprietor_user }
  let(:signup_url) { '/users/signup' }

  context 'when creating a new valid user' do
    before do
      post signup_url, params: { user: {
        email: proprietor_user.email, password: proprietor_user.password,
        password_confirmation: proprietor_user.password_confirmation,
        is_occupant: proprietor_user.is_occupant, is_proprietor: proprietor_user.is_proprietor
      } }
    end

    it 'returns created (201)' do
      puts "Response status: #{response.status}"
      Rails.logger.info "Response status 2: #{response.status}"
      expect(response).to have_http_status :created
    end

    it 'returns a success message' do
      json_response = response.parsed_body
      puts "Response body: #{json_response}"
      Rails.logger.info "Response body 2: #{json_response}"
      expect(json_response['message']).to eq("You've signed up successfully.")
    end
  end

  context 'when creating an invalid user with missing required field(s)' do
    before do
      post signup_url, params: { user: {
        email: proprietor_user.email,
        password: proprietor_user.password,
        password_confirmation: proprietor_user.password_confirmation
      } }
    end

    it 'returns unprocessable entity (422)' do
      puts "Response status: #{response.status}"
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
