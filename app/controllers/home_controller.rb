class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @public_courses = Course.where(permission: 'Public', is_destroyed: false)
      @popular_courses = Course.where(is_destroyed: false)
      @org_courses = Course.where(permission: 'Public', author_type: "Organization", is_destroyed: false)
      @current_courses = @user.courses_with_status("is_started").paginate(page: params[:current_page], per_page: 2)
      @finished_courses = @user.courses_with_status("is_finished").paginate(page: params[:finished_page], per_page: 2)
      @liked_courses =  @user.courses_with_status("is_liked").paginate(page: params[:liked_page], per_page: 2)
    end
  end

end
