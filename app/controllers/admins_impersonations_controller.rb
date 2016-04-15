class AdminsImpersonationsController < ApplicationController

  before_action :find_user, only: [:index]

  def index
    @impersonations = @user.admins_impersonations.ordered.paginate(page: params[:page], per_page: 5)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
