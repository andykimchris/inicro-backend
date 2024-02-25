# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookingJobs::MailToLeadJob do
  subject(:perform) { described_class.new.perform(booking_id) }

  describe '#perform' do
    let(:booking) { create(:booking) } # assuming you have FactoryBot configured
    let(:booking_id) { booking.id }

    context 'when fine submission' do
      it 'sends booking information to lead' do
        specify do
          allow(Bookings::SendBookingToLeadMailer).to receive(:send_booking_to_lead)
          perform

          expect(Bookings::SendBookingToLeadMailer).to have_received(:send_booking_to_lead)
            .with(booking:, unit: booking.unit)
        end
      end

      it 'updates mailer count' do
        expect { perform }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end

    context 'when booking id is nil' do
      let(:booking_id) { nil }

      specify do
        expect { perform }.not_to raise_error
      end
    end
  end
end
