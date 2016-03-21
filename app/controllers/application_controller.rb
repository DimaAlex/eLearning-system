class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :is_admin?

  private
    def is_admin?
      if user_signed_in?
        current_user.is_admin ? render('admin/index') : render('home/index')
      end
    end
end
