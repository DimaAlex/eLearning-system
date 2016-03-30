class OrgAdminsController < ApplicationController

  def index

  end

  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    redirect_to root_path
  end

  def stop_impersonate
    stop_impersonating_user
    redirect_to root_path
  end

end
