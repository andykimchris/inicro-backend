# frozen_string_literal: true

require 'active_storage_validations'

class Listing < ApplicationRecord
  IMAGE_FORMATS = [
    'image/png',
    'image/jpg',
    'image/jpeg',
    'image/webp',
    'image/avif',
    'image/gif'
  ].freeze

  belongs_to :user, class_name: 'User', primary_key: 'id', inverse_of: :listings
  belongs_to :location
  has_many :listing_amenities, class_name: 'ListingAmenity', dependent: :destroy

  has_many_attached :images

  enum listing_type: { residential: 0, commercial: 1, land: 2 }

  validates :title, :description, presence: true
  validates :floor_count, presence: true, if: -> { listing_type.in?(%w[residential commercial]) }

  HTTPS_URL_REGEX = %r{\Ahttps://\S+\z}
  validates :site_link, format: { with: HTTPS_URL_REGEX, message: :site_link_format }, allow_blank: true

  validates :images, attached: true,
                     content_type: IMAGE_FORMATS,
                     size: { less_than: 3.megabytes },
                     length: { maximum: 15 }
end
