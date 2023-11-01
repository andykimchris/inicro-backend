# frozen_string_literal: true

FactoryBot.define do
  factory :listing_amenity do
    listing { nil }
    onsite_parking { false }
  end
end
