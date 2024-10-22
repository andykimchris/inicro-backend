# frozen_string_literal: true

class Unit < ApplicationRecord
  belongs_to :listing
  belongs_to :user, optional: true

  has_many :unit_wishlists, dependent: :nullify
  has_many :users, through: :unit_wishlists
  has_many :bookings, dependent: :destroy

  has_one_attached :floorplan_image
  has_many_attached :images

  enum :unit_type, { studio: 0, '1-bedroom': 1, '2-bedroom': 2, '3-bedroom': 3 }
  enum :unit_lease_type, { rental: 0, purchase: 1 }

  validates :amount, :unit_type, :unit_lease_type, presence: true
  validates :floorplan_image,
            content_type: Constants::IMAGE_FORMATS,
            size: { less_than: 1.megabyte }

  validates :images,
            content_type: Constants::IMAGE_FORMATS,
            size: { less_than: 3.megabytes },
            length: { maximum: 5 }

  validate :user_is_occupant

  private

  def user_is_occupant
    return if user.nil? || user.is_occupant

    errors.add(:user, 'assigned user must be an occupant')
  end
end
