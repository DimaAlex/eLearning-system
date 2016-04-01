class UsersController < ApplicationController

  def profile
    @user = User.find(params[:id])
  end


  def show
    @user = current_user
    respond_to do |format|
      format.pdf { send_file TestPdfForm.new(@user).export, type: 'application/pdf' }
    end
  end

end
