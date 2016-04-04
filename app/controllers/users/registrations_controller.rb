class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end


  protected
    def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name,
     :email, :password, :password_confirmation, :current_password, :avatar, :country) }
  end

end
