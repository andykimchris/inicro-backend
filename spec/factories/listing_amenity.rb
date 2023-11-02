# frozen_string_literal: true

FactoryBot.define do
  factory :listing_amenity do
    title { 'MyString' }
    description { 'MyText' }
    is_available { false }
    metadata { 'MyText' }
    listing { nil }
  end
end
