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
          expect(json_response).to have_key(:unit)
        end
      end
    end
  end

  describe 'POST /unit' do
    context 'when creating a unit as a proprietor' do
      let(:create_unit_url) { '/api/v1/units/' }
      let(:listing) { create_listing }
      let(:login_url) { '/users/login/' }
      let(:user) { create_proprietor_user }

      before do
        post login_url, params: { user: { email: user.email, password: user.password } }
        post create_unit_url,
             params: { listing_id: listing.id, size: 85, amount: 25_000, unit_type: '2-bedroom', is_available: true,
                       unit_lease_type: 'rental' }
      end

      it 'returns created (201) status' do
        expect(unit).to be_valid
        expect(response).to have_http_status :created
      end

      it 'returns a unit object' do
        json_response = response.parsed_body
        expect(json_response).to have_key(:unit)
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
