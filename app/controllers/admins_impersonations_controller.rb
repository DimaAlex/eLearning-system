class AdminsImpersonationsController < ApplicationController

  before_action :find_user, only: [:index]
  before_action :set_impersonation, only: [:destroy]

  def index
    @impersonations = @user.admins_impersonations.ordered.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @impersonation.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Impersonation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def set_impersonation
    @impersonation = AdminsImpersonation.find(params[:id])
  end

end
