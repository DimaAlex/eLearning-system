require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = create(:user) }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:is_admin) }
  it { should respond_to(:country) }

  describe "#check_finish" do
    let(:users_course) { @user.users_courses.create(is_started: true) }

    it "return progress 25" do
      expect(@user.check_finish(users_course, 25)).to eq 25
    end

    context 'user progress is 100, course is finished' do
      before {@user.check_finish(users_course, 100)}

      it "return true" do
        expect(users_course.is_finished).to eq true
      end
    end
  end

  describe "#course_finished?" do
    let(:not_user_course) {create(:course)}
    let(:course) {create(:course)}
    before {@user_course = @user.users_courses.create(course_id: course.id,is_finished: false)}

    it "return false" do
      expect(@user.course_finished?(course)).to eq false
    end

    it "return nil" do
      expect(@user.course_finished?(not_user_course)).to eq nil
    end

    context "user finished course" do
      before do
        @user_course.is_finished = true
        @user_course.save
      end

      it "return true" do
        expect(@user.course_finished?(course)).to eq true
      end
    end
  end
end
