# frozen_string_literal: true

FactoryBot.define do
  factory :one_bedroom_unit do
    listing { association(:listing) }
    user { association(:occupant_user) }
    size { 100 }
    amount { 15_000 }
    unit_type { 1 }
    bedroom_count { 1 }
    bathroom_count { 2 }
    full_bathroom_count { 1 }
    floorplan_image { 'https://host-inicro:image1-jpg.com' }
    description { ' 12-month lease. Please visit our website to schedule a tour.' }
    identifier { 'BO4' }
    is_available { false }
    availability_date { nil }
  end

  factory :studio_unit do
    listing { association(:listing) }
    user { nil }
    size { 85 }
    amount { 15_000 }
    unit_type { 0 }
    bedroom_count { 0 }
    bathroom_count { 2 }
    full_bathroom_count { 1 }
    floorplan_image { 'https://host-inicro:image2-jpg.com' }
    description { ' 12-month lease. Please visit our website to schedule a tour.' }
    identifier { 'BO3' }
    is_available { true }
    availability_date { Time.now.utc + 21.days }
  end
end
