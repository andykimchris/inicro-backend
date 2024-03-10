# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Bookings' do
  let(:proprietor) { create_proprietor_user }
  let(:bookings_url) { '/api/v1/bookings/' }
  let(:listing) { create(:listing, user_id: proprietor.id) }
  let(:unit) { create(:one_bedroom_unit, listing:) }

  describe 'GET /index' do
    before do
      create_list(:booking, 3, unit:, assigned_to_id: proprietor.id)
      post '/users/login/', params: { user: { email: proprietor.email, password: proprietor.password } }
      get bookings_url
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the bookings associated with listing owner' do
      result = response.parsed_body

      expect(result).to have_key('bookings')
      expect(result['bookings']).to be_present
      expect(result['bookings'].size).to eq(3)
    end
  end

  describe 'POST /bookings' do
    context 'when creating a booking' do
      before do
        booking_params = attributes_for(:booking)
        post bookings_url, params: booking_params.merge(unit_id: unit.id)
      end

      specify do
        expect(response).to have_http_status :created

        booking = Booking.last
        expect(booking.assigned_to_id).to eq(proprietor.id)

        result = response.parsed_body
        expect(result).to have_key('success')
        expect(result['success']).to be(true)
      end
    end
  end
end
