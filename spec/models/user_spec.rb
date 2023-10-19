require 'rails_helper'

RSpec.describe User, type: :model do

  context "when validating proprietor vs occupant information" do
    it "creates a valid user when one is true and the other is false" do
      user = create_user
      expect(user).to be_valid
    end

    it "returns unprocessable entity (422) when both share the same data" do
      user = User.new(
        email: "johndoe@mail.com",
        password: "johndoe123!",
        password_confirmation: "Johndoe123!",
        is_occupant: true,
        is_proprietor: true
      )

      expect(user).not_to be_valid
    end
  end


  context "when validating user password" do
    it "creates a valid user when password & password confirmation match" do
      user = create_user
      expect(user).to be_valid
    end

    it "returns unprocessable entity (422) when password doesn't match regex" do
      user = User.new(
        email: "johndoe@mail.com",
        password: "johndoe123!",
        password_confirmation: "Johndoe123!",
        is_occupant: true,
        is_proprietor: false
      )

      expect(user).not_to be_valid
      expect(user.errors[:password]).to include ("must include at least one lowercase letter, one uppercase letter, one digit, and one special character.")
    end

  end
end
