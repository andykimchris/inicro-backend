# frozen_string_literal: true

FactoryBot.define do
  factory :proprietor_user, class: 'User' do
    email { Faker::Internet.email }
    password { 'Johndoe123&' }
    password_confirmation { 'Johndoe123&' }
    is_occupant { false }
    is_proprietor { true }
    confirmed_at { Time.zone.now }
    confirmation_token { SecureRandom.hex }
  end

  factory :occupant_user, class: 'User' do
    email { Faker::Internet.email }
    password { 'Johndoe123&' }
    password_confirmation { 'Johndoe123&' }
    is_occupant { false }
    is_proprietor { true }
    confirmed_at { Time.zone.now }
    confirmation_token { SecureRandom.hex }
  end

  factory :unauthenticated_user, class: 'User' do
    email { Faker::Internet.email }
    password { 'Janedoe123&' }
    password_confirmation { 'Janedoe123&' }
    is_occupant { true }
    is_proprietor { false }
    confirmed_at { nil }
  end
end
