# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :user, class_name: 'User', primary_key: 'id', inverse_of: :listings
  belongs_to :location

  enum listing_type: { residential: 0, commercial: 1, land: 2 }

  validates :title, :description, presence: true

  HTTPS_URL_REGEX = %r{\Ahttps://\S+\z}
  validates :site_link, format: { with: HTTPS_URL_REGEX, message: :site_link_format }, allow_blank: true
end
