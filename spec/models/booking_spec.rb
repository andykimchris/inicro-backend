# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Booking do
  describe 'validations' do
    let(:unit) { create(:one_bedroom_unit) }

    context 'when unit is not available' do
      it 'raises error' do
        booking = described_class.new(
          unit:, email: 'test1@example.com', booking_set_at: Time.now.utc + 4.days,
          phone_number: '344-233-4343', booking_assigned_to_id: unit.listing.user_id
        )

        expect(booking).not_to be_valid
        expect(booking.errors).to be_present
        expect(booking.errors[:unit]).to include('is not available for booking.')
      end
    end

    context 'when unit is already booked by user' do
      let(:unit) { create(:studio_unit) }

      before do
        create(:booking, unit:, email: 'test@example.com', booking_set_at: Time.now.utc + 4.days)
      end

      it 'raises error' do
        booking = described_class.new(
          unit:, email: 'test@example.com', booking_set_at: Time.now.utc + 4.days,
          phone_number: '344-233-4343', booking_assigned_to_id: unit.listing.user_id
        )

        expect(booking).not_to be_valid
        expect(booking.errors).to be_present
        expect(booking.errors[:base]).to include('You have already booked this unit.')
      end
    end
  end
end
