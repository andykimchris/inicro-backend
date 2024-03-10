# frozen_string_literal: true

module BookingJobs
  class MailToLeadJob < ApplicationJob
    queue_as :default

    def perform(booking_id)
      booking = Booking.find_by(id: booking_id)
      return unless booking

      unit = booking.unit
      Bookings::SendBookingToLeadMailer.with(booking:, unit:).send_booking_to_lead.deliver_later
    end
  end
end
