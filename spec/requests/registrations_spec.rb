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
      expect(response).to have_http_status :created
    end

    it 'returns a success message' do
      json_response = response.parsed_body
      expect(json_response['message']).to eq("You've signed up sucessfully.")
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

    it 'returns unprocessable entity (442)' do
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
