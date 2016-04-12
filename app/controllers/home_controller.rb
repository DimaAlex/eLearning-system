class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @current_courses = @user.courses_with_status("is_started").paginate(page: params[:current_page], per_page: 2)
      @finished_courses = @user.courses_with_status("is_finished").paginate(page: params[:finished_page], per_page: 2)
      @liked_courses =  @user.courses_with_status("is_liked").paginate(page: params[:liked_page], per_page: 2)
    end
  end
end
