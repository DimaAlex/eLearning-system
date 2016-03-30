class AdminImpersonationsController < ApplicationController

  def index
    @impersonations = AdminsImpersonation.all
  end
end
