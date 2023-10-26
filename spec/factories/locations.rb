# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    longitude { 34.43443 }
    latitude { 34.435 }
    name { 'Gendeza Heights' }
    city { 'Nairobi' }
    state { 'Nairobi' }
    country { 'Kenya' }
  end
end
