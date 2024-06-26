# frozen_string_literal: true

require 'faker'

class Seeding
  def call
    seed_user_data
    seed_listing_data
    seed_location_data
    seed_listing_unit_data
    seed_booking
    seed_listing_amenities_data
  end

  def seed_user_data
    FactoryBot.create(:proprietor_user)
    FactoryBot.create_list(:occupant_user, 3)
  end

  def seed_listing_data
    FactoryBot.create(:listing)
  end

  def seed_location_data
    FactoryBot.create(:location)
  end

  def seed_listing_unit_data
    FactoryBot.create(:one_bedroom_unit)
  end

  def seed_booking
    FactoryBot.create(:booking)
  end

  def seed_listing_amenities_data
    # FactoryBot.create(:security_cameras)
    # FactoryBot.create(:gymnasium)
  end
end

seeding = Seeding.new
seeding.call

Rails.logger.debug 'Successfully seeded data'
