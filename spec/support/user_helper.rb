# frozen_string_literal: true

require 'faker'
require 'factory_bot_rails'

module UserHelpers
  def create_occupant_user
    FactoryBot.create(:occupant_user, email: Faker::Internet.email, password: 'Johndoe123&', is_occupant: true,
                                      is_proprietor: false)
  end

  def build_occupant_user
    FactoryBot.build(:occupant_user, email: Faker::Internet.email, password: 'Johndoe123&', is_occupant: true,
                                     is_proprietor: false)
  end

  def create_proprietor_user
    FactoryBot.create(:proprietor_user, email: Faker::Internet.email, password: 'Johndoe123&', is_occupant: false,
                                        is_proprietor: true)
  end

  def build_proprietor_user
    FactoryBot.build(:proprietor_user, email: Faker::Internet.email, password: 'Johndoe123&', is_occupant: false,
                                       is_proprietor: true)
  end
end
