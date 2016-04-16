class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  around_action :handle_exceptions

  helper_method :mailbox, :conversation

  before_filter :configure_devise_params, if: :devise_controller?

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :country, :email, :password, :password_confirmation)
    end
  end


  def handle_exceptions
    begin
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to errors_not_found_path
    end
  end

  impersonates :user

  private
  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end
end
