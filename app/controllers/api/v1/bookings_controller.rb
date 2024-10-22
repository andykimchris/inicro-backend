# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      before_action :authenticate_user!, only: %i[index]
      before_action :user_must_be_proprietor, only: %i[index]

      def index
        bookings = Booking.joins(unit: :listing).where(listing: { user_id: current_user.id })
        render json: { success: true, bookings: }, status: :ok
      end

      def create
        booking = Booking.new(booking_params)

        if booking.save
          assign_booking_to_listing_owner(booking)

          BookingJobs::MailToLeadJob.perform_later(booking.id)
          render json: { success: true }, status: :created
        else
          render json: { error: booking.errors.full_messages.join(', ') }, status: :unprocessable_content
        end
      end

      private

      def booking_params
        params.permit(:unit_id, :first_name, :last_name, :email, :phone_number, :scheduled_at)
      end

      def assign_booking_to_listing_owner(booking)
        booking.update!(assigned_to_id: booking.unit.listing.user_id)
      end
    end
  end
end
