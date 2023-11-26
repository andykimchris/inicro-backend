# frozen_string_literal: true

require 'faker'
require 'factory_bot_rails'

module UserHelpers
  def create_occupant_user
    FactoryBot.create(:occupant_user)
  end

  def build_occupant_user
    FactoryBot.build(:occupant_user)
  end

  def create_proprietor_user
    FactoryBot.create(:proprietor_user)
  end

  def build_proprietor_user
    FactoryBot.build(:proprietor_user)
  end
end
