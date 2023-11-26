# frozen_string_literal: true

FactoryBot.define do
  factory :location, class: 'Location' do
    longitude { 34.43443 }
    latitude { 34.435 }
    description { 'Lorem Ipsum' }
    name { 'Gendeza Heights' }
    address { '540 Rodeo Drive' }
    city { 'Nairobi' }
    state { 'Nairobi' }
    country { 'Kenya' }
  end
end
