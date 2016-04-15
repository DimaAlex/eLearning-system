require 'rails_helper'

RSpec.describe UsersController, type: :controller, test: true do
  let(:user) { FactoryGirl.build_stubbed(:user) }

   describe "GET #profile" do
    it "assing @user" do
      expect(User).to receive(:find).and_return user
      get :profile, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  # describe "GET #show" do
  #   expect_any_instance_of()
  #   it "assing @user" do
  #     expect(subject).to receive(:current_user).and_return user
  #     get :show
  #     expect(assigns(:user)).to eq(user)
  #   end
  # end
end
