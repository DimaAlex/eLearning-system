require "rails_helper"

RSpec.describe AdminsImpersonationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "admins_impersonations/1/index").to route_to("admins_impersonations#index", id: "1")
    end
  end
end

