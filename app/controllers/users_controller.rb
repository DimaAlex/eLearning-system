class UsersController < ApplicationController

  def profile
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      @page = @user.answers.last.page
      redirect_to finish_page_url(course_id: @page.course.id, id: @page.id)
    else
      redirect_to :back
    end
  end

  private
  def user_params
    params.require(:user).permit(answer_ids:[])
  end

end
