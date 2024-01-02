# frozen_string_literal: true

class Unit < ApplicationRecord
  belongs_to :listing
  belongs_to :user, optional: true

  has_one_attached :floorplan_image
  has_many_attached :images

  enum unit_type: { studio: 0, '1-bedroom': 1, '2-bedroom': 2, '3-bedroom': 3 }
  enum unit_lease_type: { rental: 0, purchase: 1 }

  validates :amount, :unit_type, :unit_lease_type, presence: true
  validates :floorplan_image,
            content_type: Constants::IMAGE_FORMATS,
            size: { less_than: 1.megabyte }

  validates :images,
            content_type: Constants::IMAGE_FORMATS,
            size: { less_than: 3.megabytes },
            length: { maximum: 5 }

  validate :user_is_occupant

  def image_urls(base_url)
    images.map { |image| image_url(base_url, image) }
  end

  def floorplan_image_url(base_url)
    image_url(base_url, floorplan_image)
  end

  private

  def image_url(base_url, image)
    "#{base_url}#{Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)}"
  end

  def user_is_occupant
    return unless user&.is_proprietor?

    errors.add(:user, 'must be an occupant')
  end
end
