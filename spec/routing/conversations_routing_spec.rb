require "rails_helper"

RSpec.describe ConversationsController, type: :routing do
  describe "routing" do

    it "routes to #get_recipients" do
      expect(get: "conversations/get_recipients").to route_to("conversations#get_recipients")
    end

  end
end
