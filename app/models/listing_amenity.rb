# frozen_string_literal: true

class ListingAmenity < ApplicationRecord
  belongs_to :listing

  validates :title,  presence: true

  enum listing_type: { residential: 0, commercial: 1, land: 2 }
end
