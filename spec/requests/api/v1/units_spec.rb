# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Units' do
  let(:unit) { create(:one_bedroom_unit) }

  describe 'GET /unit' do
    context 'when showing a unit' do
      let(:unit_url) { "/api/v1/units/#{unit.id}" }

      context 'with valid listing ID' do
        before { get unit_url }

        it 'returns a successful response' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns the requested unit' do
          expect(unit).to be_valid
          json_response = response.parsed_body
          expect(json_response).to have_key('unit')
        end
      end
    end
  end

  describe 'PUT /unit' do
    let(:update_url) { "/api/v1/units/#{unit.id}" }

    context 'when proprietor is not authenticated' do
      let(:proprietor_user) { create_proprietor_user }
      let(:unit) { create(:studio_unit) }

      it 'returns unauthorized (401) status' do
        put update_url, params: { identifier: 'J039', amount: 25_000 }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when proprietor is authenticated' do
      let(:proprietor) { create_proprietor_user }
      let(:unit) { create(:studio_unit) }
      let(:login_url) { '/users/login/' }

      before do
        post login_url, params: { user: { email: proprietor.email, password: proprietor.password } }
      end

      context 'with valid params' do
        it 'updates the unit' do
          put update_url, params: { id: unit.id, identifier: 'J039', amount: 25_000 }
          expect(response).to have_http_status :ok
          expect(unit.reload.identifier).to eq('J039')
        end
      end
    end
  end
end
