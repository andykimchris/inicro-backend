# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Listings' do
  include ListingHelpers

  describe 'POST /listings' do
    let(:listing) { create_listing }
    let(:location) { create_location }

    let(:login_url) { '/users/login/' }
    let(:create_listing_url) { '/api/v1/listing/' }

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
end
