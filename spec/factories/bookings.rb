# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    unit { association(:one_bedroom_unit) }
    first_name { Faker::Name.first_name }
    last_name { Fake::Name.last_name }
    phone_number { Faker::Internet.phone_number }
    email { Faker::Internet.email }
    booking_set_at { '2024-02-18 17:59:33' }
    booking_assigned_to_id { SecureRandom.uuid }
  end
end
