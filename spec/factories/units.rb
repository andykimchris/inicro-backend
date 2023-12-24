# frozen_string_literal: true

FactoryBot.define do
  factory :one_bedroom_unit, class: 'Unit' do
    listing { association(:listing) }
    user { association(:occupant_user) }
    size { 100 }
    amount { 15_000 }
    unit_type { 1 }
    bedroom_count { 1 }
    bathroom_count { 2 }
    full_bathroom_count { 1 }
    description { ' 12-month lease. Please visit our website to schedule a tour.' }
    identifier { 'BO4' }
    is_available { false }
    unit_lease_type { 0 }
    availability_date { nil }

    after(:build) do |unit|
      image_path = Rails.root.join('spec/factories/media/images/listing-1.jpg')
      unit.images.attach(io: Rails.public_path.join(image_path).open, filename: 'listing-1.jpg',
                         content_type: 'image/jpg')
    end
  end

  factory :studio_unit, class: 'Unit' do
    listing { association(:listing) }
    user { nil }
    size { 85 }
    amount { 15_000 }
    unit_type { 0 }
    bedroom_count { 0 }
    bathroom_count { 2 }
    full_bathroom_count { 1 }
    description { ' 12-month lease. Please visit our website to schedule a tour.' }
    identifier { 'BO3' }
    is_available { true }
    unit_lease_type { 0 }
    availability_date { Time.now.utc + 21.days }
  end
end
