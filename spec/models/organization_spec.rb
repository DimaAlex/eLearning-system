require 'rails_helper'

RSpec.describe Organization, type: :model do
  before { @organization = create(:organization) }

  subject { @organization }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:phone) }
  it { should respond_to(:image_file_name) }

  describe '#is_org_admin?' do
    let(:new_user) { create(:user) }
    it "return 'false' when user is not admin of organization" do
      expect(@organization.is_org_admin?(new_user)).to eq false
    end

    it "return 'false' when user is nil" do
      expect(@organization.is_org_admin?(nil)).to eq false
    end

    context 'add user in org admins of organization' do
      before { @organization.users_organizations.create(user_id: new_user.id, is_org_admin: true) }
      it "return 'true' if user is org admin" do
        expect(@organization.is_org_admin?(new_user)).to eq true
      end
    end
  end

end
