# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions' do
  let(:proprietor_user) { create_proprietor_user }
  let(:login_url) { '/users/login' }
  let(:logout_url) { '/users/logout' }

  context 'when logging in a user' do
    before do
      post login_url, params: { user: { email: proprietor_user.email, password: proprietor_user.password } }
    end

    it 'returns ok (200)' do
      expect(response).to have_http_status :ok
    end

    it 'returns a bearer token in response headers' do
      expect(response.headers['Authorization']).to be_present
    end
  end

  context 'when password or email is missing' do
    before do
      post login_url, params: { user: { email: proprietor_user.email } }
    end

    it 'returns unauthorized (401)' do
      expect(response).to have_http_status :unauthorized
    end
  end

  context 'when logging out a user' do
    it 'returns no content (204)' do
      delete logout_url

      expect(response).to have_http_status :no_content
    end
  end
end
