# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/bookings/send_booking_to_lead
module Bookings
  class SendBookingToLeadPreview < ActionMailer::Preview
    def send_booking_to_lead
      booking = Booking.first
      unit = booking.unit

      Bookings::SendBookingToLeadMailer.send_booking_to_lead(booking:, unit:)
    end
  end
end
