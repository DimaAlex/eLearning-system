require "rails_helper"

RSpec.describe MailboxController, type: :routing do
  describe "routing" do

    it "routes to #inbox" do
      expect(get: "/mailbox/inbox").to route_to("mailbox#inbox")
    end

    it "routes to #sent" do
      expect(get: "/mailbox/sent").to route_to("mailbox#sent")
    end

    it "routes to #trash" do
      expect(get: "/mailbox/trash").to route_to("mailbox#trash")
    end

  end
end
