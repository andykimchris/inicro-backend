require "faker"
require "factory_bot_rails"

module UserHelpers

  def create_user
    FactoryBot.create(:user, email: Faker::Internet.email, password: "Johndoe123&", is_occupant: false, is_proprietor: true)
  end

  def build_user
    FactoryBot.build(:user, email: Faker::Internet.email, password: "Johndoe123&", is_occupant: false, is_proprietor: true)
  end

end

