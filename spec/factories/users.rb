# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Johndoe123&' }
    password_confirmation { 'Johndoe123&' }
    is_occupant { false }
    is_proprietor { true }
  end
end
