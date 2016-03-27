class AdminController < ApplicationController
  before_action :is_not_admin?

  def index

  end

  private
  def is_not_admin?
     unless current_user && current_user.is_admin
       flash[:error] = "You can't see this page."
       redirect_to root_path
    end
  end

end
