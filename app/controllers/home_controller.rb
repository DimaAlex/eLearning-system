class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @public_courses = Course.where(permission: 'Public')
      @current_courses = @user.users_courses.where(is_started: true).map {|x| x.course}
      @finished_courses = @user.users_courses.where(is_finished: true).map {|x| x.course}
      @popular_courses = Course.all
      @current_courses = @user.courses_with_status("is_started").paginate(page: params[:current_page], per_page: 2)
      @finished_courses = @user.courses_with_status("is_finished").paginate(page: params[:page], per_page: 2)
      @liked_courses =  @user.courses_with_status("is_liked").paginate(page: params[:liked_page], per_page: 2)
      @org_courses = Course.where(permission: 'Public').where(author_type: "Organization")
    end
  end

end
