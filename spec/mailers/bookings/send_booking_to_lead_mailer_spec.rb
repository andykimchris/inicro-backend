# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookings::SendBookingToLeadMailer do
  let(:booking) { create(:booking) } # Assuming you have FactoryBot configured
  let(:unit) { booking.unit }
  let(:mail) { described_class.send_booking_to_lead(booking:, unit:) }

  describe '#send_booking_to_lead' do
    it 'renders the headers' do
      expect(mail.subject).to eq("Booking for #{booking.full_name}")
      expect(mail.to).to eq([booking.email])
      expect(mail.from).to eq(["Inicro #{BASE_SENDER}"])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(booking.first_name)
      expect(mail.body.encoded).to match(booking.last_name)
      expect(mail.body.encoded).to match(unit.listing.title)
    end
  end
end
