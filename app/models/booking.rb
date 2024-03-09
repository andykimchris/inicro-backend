# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :unit

  validates :email, :booking_set_at, presence: true

  # TODO: validate that the same unit can't be booked twice by the same user
  # TODO: validate that you can't book a unit that is not available
  # TODO : set callback action on booking_assigned_to_id on creation to listing owner

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
