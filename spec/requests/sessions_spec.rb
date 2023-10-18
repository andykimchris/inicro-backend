require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  let(:user) { create_user }
  let(:login_url) { "/users/login" }
  let(:logout_url) { "/users/logout" }

  context "when logging in a user" do
    before do
      post login_url, params: { user: { email: user.email, password: user.password } }
    end

    it "returns ok (200)" do
      expect(response.status).to eq 200
    end

    it "returns a bearer token in response headers" do
      expect(response.headers["Authorization"]).to be_present
    end
  end

  context "when password or email is missing" do
    before do
      post login_url, params: { user: { email: user.email } }
    end

    it "returns unauthorized (401)" do
      expect(response.status).to eq 401
    end
  end

  context "when logging out a user" do
    it "returns no content (204)" do
      delete logout_url

      expect(response.status).to eq 204
    end
  end

end
