class UsersController < ApplicationController

  before_action :find_user, only: [:profile, :courses, :organizations]

  def profile
  end

  def courses
    @courses = Course.where(author: @user, is_destroyed: false).paginate(page: params[:page], per_page: 4)
  end

  def organizations
    @organizations = @user.organizations.paginate(page: params[:page], per_page: 4)
  end

  def show
    @user = current_user
    respond_to do |format|
      format.pdf { send_file TestPdfForm.new(@user).export, type: 'application/pdf' }
    end
  end

  def certificates
    @certificates = UsersCourse.where(user_id: current_user.id, status_course: "Success").joins(:course).paginate(page: params[:page], per_page: 3)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
