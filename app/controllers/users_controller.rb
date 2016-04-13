class UsersController < ApplicationController

  before_action :find_user, only: [:profile, :courses]

  def profile
  end

  def courses
    @courses = Course.where(author_id: @user.id, permission:"Public").paginate(page: params[:page], per_page: 4)
  end


  def show
    @user = current_user
    respond_to do |format|
      format.pdf { send_file TestPdfForm.new(@user).export, type: 'application/pdf' }
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
