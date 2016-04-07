class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @public_courses = Course.where(permission: 'Public')
      @current_courses = @user.users_courses.where(is_started: true).map {|x| x.course}
      @finished_courses = @user.users_courses.where(is_finished: true).map {|x| x.course}
    end
  end
end
