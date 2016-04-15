require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #profile" do
      expect(get: "/user/1").to route_to("users#profile", id: "1")
    end

  end
end
