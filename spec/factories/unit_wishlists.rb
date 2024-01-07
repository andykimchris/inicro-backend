# frozen_string_literal: true

FactoryBot.define do
  factory :unit_wishlist do
    user { association(:occupant_user) }
    unit { association(:studio_unit) }
    title { 'Studio Units' }
    saved_at { '2024-01-07 18:59:38' }
  end
end
