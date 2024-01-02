# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Listings' do
  let(:listing) { create_listing }
  let(:location) { create_location }

  describe 'GET /listing' do
    context 'when showing a listing' do
      let(:listing_url) { "/api/v1/listings/#{listing.id}" }

      context 'with valid listing ID' do
        before { get listing_url }

        it 'returns a successful response' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns the requested listing' do
          expect(listing).to be_valid

          json_response = response.parsed_body
          expect(json_response).to have_key('listing')
          expect(json_response['listing']['fields']['id']).to eq(listing.id)
        end
      end

      context 'with invalid listing ID' do
        let(:listing_url) { '/api/v1/listings/:id' }

        before do
          get listing_url, params: { id: 'invalid_id' }
        end

        it 'returns a not found (404) status' do
          expect(response).to have_http_status(:not_found)
        end

        it 'returns an error message for listing not found' do
          expect(response.parsed_body['error']).to eq('Listing not found')
        end
      end
    end
  end

  describe 'POST /listings' do
    let(:create_listing_url) { '/api/v1/listings/' }
    let(:login_url) { '/users/login/' }

    context 'when creating a listing as an authenticated proprietor' do
      let(:proprietor_user) { create_proprietor_user }

      before do
        post login_url, params: { user: { email: proprietor_user.email, password: proprietor_user.password } }
        image_path = Rails.root.join('spec/factories/media/images/listing-1.jpg')
        listing_params = attributes_for(:listing, location_id: location.id,
                                                  images: [fixture_file_upload(image_path, 'image/jpg')])
        post create_listing_url, params: listing_params
      end

      it 'returns created (201) status' do
        expect(listing).to be_valid
        expect(response).to have_http_status :created
      end

      it 'returns a listing object key' do
        json_response = response.parsed_body
        expect(json_response).to have_key('listing')
      end
    end

    context 'when attempting to create a listing as occupant' do
      let(:occupant_user) { create_occupant_user }

      before do
        post login_url, params: { user: { email: occupant_user.email, password: occupant_user.password } }
        image_path = Rails.root.join('spec/factories/media/images/listing-1.jpg')
        listing_params = attributes_for(:listing, location_id: location.id,
                                                  images: [fixture_file_upload(image_path, 'image/jpg')])

        post create_listing_url, params: listing_params
      end

      it 'return forbidden (403) status' do
        expect(response).to have_http_status :forbidden
      end
    end
  end

  describe 'PUT /listing' do
    let(:location) { create_location }
    let(:update_listing_url) { "/api/v1/listings/#{listing.id}" }

    context 'when user is not authenticated' do
      let(:proprietor_user) { create_proprietor_user }
      let(:listing) { create_listing }

      it 'returns unauthorized (401) status' do
        put update_listing_url, params: { title: 'New Title' }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is authenticated' do
      let(:proprietor_user) { create_proprietor_user }
      let(:listing) { create_listing }
      let(:login_url) { '/users/login/' }

      before do
        post login_url, params: { user: { email: proprietor_user.email, password: proprietor_user.password } }
      end

      context 'with valid params' do
        it 'returns ok (200) status' do
          expect(response).to have_http_status :ok
        end

        it 'updates the listing' do
          patch update_listing_url, params: { id: listing.id, title: 'New Title' }
          listing.reload
          expect(listing.title).to eq('New Title')
        end
      end

      context 'with invalid params' do
        it 'returns unprocessable entity (422) status' do
          patch update_listing_url, params: { id: listing.id, title: '' }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when the listing is not found' do
        let(:update_listing_url) { '/api/v1/listing/:id' }

        it 'returns not found status' do
          put update_listing_url, params: { id: 'invalid_id', title: 'Updated Title' }
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
