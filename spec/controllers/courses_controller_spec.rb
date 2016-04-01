require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  login_user

  describe "#create" do
    subject { post :create, course: { title: "MyCourse"} }

    it "redirect to new page creation" do
      expect(subject).to redirect_to course_pages_path(assigns(:course).id)
    end
  end
end
