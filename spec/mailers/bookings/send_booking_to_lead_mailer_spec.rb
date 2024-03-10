# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookings::SendBookingToLeadMailer do
  subject(:mail) { described_class.with(booking:, unit:).send_booking_to_lead }

  let(:booking) { create(:booking) }
  let(:unit) { booking.unit }
  let(:base_sender) { 'chrisandrewmuchiri@gmail.com' }

  describe '#send_booking_to_lead' do
    it 'renders the headers' do
      expect(mail.subject).to eq("Booking for #{booking.full_name}")
      expect(mail.to).to eq([booking.email])
      expect(mail.from).to eq("Inicro #{base_sender}")
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(booking.first_name)
      expect(mail.body.encoded).to match(booking.last_name)
      expect(mail.body.encoded).to match(unit.listing.title)
    end
  end
end
