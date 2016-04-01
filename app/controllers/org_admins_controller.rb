class OrgAdminsController < ApplicationController

  def impersonate
    user = User.find(params[:id])
    create_impersonation(params[:id])
    impersonate_user(user)
  end

  def stop_impersonate
    stop_impersonating_user
    update_impersonation
    redirect_to root_path
  end

  private

  def create_impersonation user_id
    impersonation = AdminsImpersonation.new(
      user_id: user_id,
      admin_id: current_user.id,
      begin_impersonation: Time.now
    )
    respond_to do |format|
      if impersonation.save
        format.html { redirect_to root_path, notice: 'New impersonation was successfully started.' }
      else
        format.html { render :new }
      end
    end
  end

  def update_impersonation
    impersonation = AdminsImpersonation.where(admin_id: current_user.id).last
    impersonation.end_impersonation = Time.now
    impersonation.save
  end

end


