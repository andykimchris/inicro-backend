# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      before_action :user_must_be_proprietor, only: %i[index]

      def index
        # TODO: Figure out how to scope this to only a specific listing or unit, and attached to listing owner
        bookings = Booking.all
        render json: { success: true, bookings: }, status: :ok
      end

      def create
        booking = Booking.new(booking_params)
        if booking.save!
          BookingJobs::MailToLeadJob.perform_later(booking.id)
          render json: { success: true }, status: :created
        else
          render json: booking.errors, status: :unprocessable_entity
        end
      end

      private

      def booking_params
        params.permit(:unit_id, :first_name, :last_name, :email, :phone_number, :booking_set_at)
      end
    end
  end
end
