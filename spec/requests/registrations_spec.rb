require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  let (:user) { build_user }
  let (:existing_user) { create_user }
  let (:signup_url) { "/users/signup" }

  context "when creating a new user" do
    before do
      post signup_url, params: { user: {
          email: user.email, password: user.password,
          password_confirmation: user.password_confirmation,
          is_occupant: user.is_occupant, is_proprietor: user.is_proprietor
        }
      }
    end

    it "returns created (201)" do
      expect(response.status).to eq 201
    end

    context "when a required field is missing" do
      before do
        post signup_url, params: { user: {
            email: user.email, password: user.password,
            password_confirmation: user.password_confirmation,
          }
        }
      end

      it "returns unprocessable entity (442)" do
        expect(response.status).to eq 422
      end
    end


    it "returns a bearer token in response headers" do
      expect(response.headers["Authorization"]).to be_present
    end

    it "returns a success message and the user" do
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq("You've signed up sucessfully.")
    end
  end

end