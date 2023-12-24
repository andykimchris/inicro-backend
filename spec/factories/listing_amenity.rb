# frozen_string_literal: true

FactoryBot.define do
  factory :security_cameras do
    title { 'Security Cameras' }
    description { Faker::Lorem.paragraph }
    is_available { true }
    metadata { 'There are surveillance cameras also on all corridors, staircases & elevators.' }
    listing { nil }
  end

  factory :gymnasium do
    title { 'Gymnasium' }
    description { Faker::Lorem.paragraph }
    is_available { false }
    metadata { 'They have free & pro plans for 1 month & 3 months.' }
    listing { nil }
  end
end
