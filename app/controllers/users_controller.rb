class UsersController < ApplicationController

  def profile
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] =  "Answered"
      @page = @user.answers.last.page
      next_page = @page.next_page
      if @page && next_page
        redirect_to course_page_path(course_id: @page.course.id, id: next_page.id)
      else
        redirect_to course_url(@page.course)
      end
    else
      redirect_to :back
    end
  end

  private
  def user_params
    params.require(:user).permit(answer_ids:[])
  end

end
