# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations' do
  let(:new_user) { build_user }
  let(:signup_url) { '/users/signup' }

  context 'when creating a new valid user' do
    before do
      post signup_url, params: { user: {
        email: new_user.email, password: new_user.password,
        password_confirmation: new_user.password_confirmation,
        is_occupant: new_user.is_occupant, is_proprietor: new_user.is_proprietor
      } }
    end

    it 'returns a bearer token in response headers' do
      expect(response.headers['Authorization']).to be_present
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
        email: new_user.email,
        password: new_user.password,
        password_confirmation: new_user.password_confirmation
      } }
    end

    it 'returns unprocessable entity (442)' do
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
