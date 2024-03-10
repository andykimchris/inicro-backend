# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :unit

  validates :email, :scheduled_at, presence: true
  validate :unit_must_be_available, on: :create
  validate :unique_booking_for_user_and_unit, on: :create

  before_save :normalize_email

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  private

  def normalize_email
    self.email = email.strip.downcase
  end

  def unit_must_be_available
    return unless unit && !unit.is_available

    errors.add(:unit, 'is not available for booking.')
  end

  def unique_booking_for_user_and_unit
    return unless Booking.exists?(unit_id:, email:)

    errors.add(:base, 'You have already booked this unit.')
  end
end
