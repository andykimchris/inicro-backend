# frozen_string_literal: true

require 'active_storage_validations'

class Listing < ApplicationRecord
  belongs_to :user, class_name: 'User', primary_key: 'id', inverse_of: :listings
  belongs_to :location
  has_many_attached :images

  enum listing_type: { residential: 0, commercial: 1, land: 2 }

  validates :title, :description, presence: true
  validates :floor_count, presence: true, if: -> { listing_type == 'residential' || listing_type == 'commercial' }

  HTTPS_URL_REGEX = %r{\Ahttps://\S+\z}
  validates :site_link, format: { with: HTTPS_URL_REGEX, message: :site_link_format }, allow_blank: true

  validates :images, attached: true,
                     content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp', 'image/avif', 'image/gif'],
                     size: { less_than: 5.megabyte },
                     length: { maximum: 15 }
end
