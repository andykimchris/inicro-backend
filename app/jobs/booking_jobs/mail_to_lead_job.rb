# frozen_string_literal: true

module BookingJobs
  class MailToLeadJob < ApplicationJob
    queue_as :default

    def perform(booking_id)
      booking = Booking.find_by(id: booking_id)
      unit = booking&.unit

      Bookings::SendBookingToLeadMailer.send_booking_to_lead(booking:, unit:).deliver_now
    end
  end
end
