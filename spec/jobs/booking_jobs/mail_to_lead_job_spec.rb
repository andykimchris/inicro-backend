# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookingJobs::MailToLeadJob do
  subject(:perform) { described_class.new.perform(booking_id) }

  describe '#perform' do
    let(:booking) { create(:booking) }
    let(:booking_id) { booking.id }

    before do
      allow(Bookings::SendBookingToLeadMailer).to receive(:with).and_call_original
    end

    context 'when fine submission' do
      specify 'sends booking information to lead' do
        perform

        expect(Bookings::SendBookingToLeadMailer).to have_received(:with)
          .with(booking:, unit: booking.unit)
      end
    end

    context 'when booking id is nil' do
      let(:booking_id) { nil }

      specify do
        expect { perform }.not_to raise_error
        expect(Bookings::SendBookingToLeadMailer).not_to have_received(:with)
      end
    end
  end
end
