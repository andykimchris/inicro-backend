# frozen_string_literal: true

module Bookings
  class SendBookingToLeadMailer < ApplicationMailer
    layout 'layouts/bookings/send_booking_to_lead_mailer'

    def send_booking_to_lead(booking:, unit:)
      @booking = booking
      @unit = unit
      @listing = unit.listing

      mail(from: "Inicro #{BASE_SENDER}", to: @booking.email, subject: "Booking for #{full_name}")
    end

    private

    def full_name
      @full_name ||= [@booking.first_name, @booking.last_name].compact.join(' ')
    end
  end
end
