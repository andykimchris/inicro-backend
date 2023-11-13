# frozen_string_literal: true

require 'faker'
require 'factory_bot_rails'

module LocationHelpers
  def create_location
    FactoryBot.create(:location,
                      name: Faker::Address.street_name,
                      description: Faker::Lorem.paragraph,
                      longitude: Faker::Address.longitude,
                      latitude: Faker::Address.latitude,
                      address: Faker::Address.street_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state,
                      country: Faker::Address.country)
  end

  def build_location
    FactoryBot.create(:location,
                      name: Faker::Address.street_name,
                      description: Faker::Lorem.paragraph,
                      longitude: Faker::Address.longitude,
                      latitude: Faker::Address.latitude,
                      address: Faker::Address.street_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state,
                      country: Faker::Address.country)
  end
end
