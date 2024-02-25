# frozen_string_literal: true

module Bookings
  class SendBookingToLeadMailer < ApplicationMailer
    layout 'layouts/bookings/send_booking_to_lead_mailer'

    def send_booking_to_lead(booking:, unit:)
      @booking = booking
      @unit = unit
      @listing = unit.listing

      mail(from: "Inicro #{BASE_SENDER}", to: @booking.email, subject: "Booking for #{@booking.full_name}")
    end
  end
end
