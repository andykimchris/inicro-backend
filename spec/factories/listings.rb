# frozen_string_literal: true

FactoryBot.define do
  factory :listing do
    title { 'MyString' }
    description { 'MyText' }
    user { nil }
    size { 10 }
    location { nil }
    metadata { 'MyText' }
    floor_count { 1 }
  end
end
