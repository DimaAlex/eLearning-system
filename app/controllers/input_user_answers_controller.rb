class InputUserAnswersController < ApplicationController

  def update
    @user = current_user
    @input_user_answer = InputUserAnswer.find(params[:id])
    if @input_user_answer.update(input_user_answer_params)
      @input_user_answer.check_answer(@user)
      @page = Page.find(@input_user_answer.page_id)
      next_page = @page.next_page
      if @page && next_page
        redirect_to course_page_path(course_id: @page.course.id, id: next_page.id)
      else
        redirect_to course_url(@page.course)
      end
    end
  end

  def create
    @user = current_user
    @input_user_answer = InputUserAnswer.new(input_user_answer_params)
    @input_user_answer.user_id = @user.id
    if @input_user_answer.save
      @input_user_answer.check_answer(@user)
      @page = Page.find(@input_user_answer.page_id)
      redirect_to finish_page_url(course_id: @page.course.id, id: @page.id)
    end
  end

  private
  def input_user_answer_params
    params.require(:input_user_answer).permit( :user_answer_body, :user_id, :page_id)
  end

end