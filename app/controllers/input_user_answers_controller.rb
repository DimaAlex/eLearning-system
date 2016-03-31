class InputUserAnswersController < ApplicationController
  before_action :set_user_and_page, only:[:update, :create]

  def update
    answer_ids = params[:input_user_answer][:answer_id]
    if answer_ids && answer_ids.is_a?(Array)
      update_checkbox_answers(answer_ids)
    else
      @input_user_answer = InputUserAnswer.find(params[:id])
      if @input_user_answer.update(input_user_answer_params)
        @input_user_answer.check_answer(@user) if @input_user_answer.user_answer_body
        redirect_to finish_page_url(course_id: @page.course.id, id: @page.id)
      end
    end
  end

  def create
    answer_ids = params[:input_user_answer][:answer_id]
    if answer_ids && answer_ids.is_a?(Array)
      update_checkbox_answers(answer_ids)
    else
      @input_user_answer = InputUserAnswer.new(input_user_answer_params)
      @input_user_answer.user_id = @user.id
      if @input_user_answer.save
        @input_user_answer.check_answer(@user) if @input_user_answer.user_answer_body
        redirect_to finish_page_url(course_id: @page.course.id, id: @page.id)
      end
    end
  end

  private

  def set_user_and_page
    @user = current_user
    @page = Page.find(params[:input_user_answer][:page_id])
  end

  def update_checkbox_answers(answer_ids)
    answer_ids.reject! { |c| c.empty? }
    @user.input_user_answers.where(page_id: @page.id).destroy_all
    answer_ids.each do |answer|
      InputUserAnswer.create(user_id: @user.id, page_id: @page.id, answer_id: answer)
    end
    redirect_to finish_page_url(course_id: @page.course.id, id: @page.id)
  end

  def input_user_answer_params
    params.require(:input_user_answer).permit( :user_answer_body, :user_id, :page_id, :answer_id)
  end

end