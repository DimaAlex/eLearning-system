class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :destroy_impersonation, only: [:destroy]

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def new
    super do |resource|
      @organizations = Organization.all
    end
  end

  def create
    super do |user|
      organizations = Organization.where(id: params.require(:user).permit(organizations: [])[:organizations])
      organizations.each do |org|
        UsersOrganization.create(user_id: user.id, organization_id: org.id, state: :followed)
      end
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, true_user, bypass: true
      respond_with true_user, location: after_update_path_for(true_user)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def destroy
    if true_user.id == resource.id
      super
    else
      stop_impersonate_path
      resource.destroy
      set_flash_message :notice, :destroyed
      respond_with_navigational(true_user){ redirect_to root_path}
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :organizations

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name,
     :email, :password, :password_confirmation, :current_password, :avatar) }
  end

  def destroy_impersonation
    AdminsImpersonation.where(user_id:current_user.id).destroy_all
  end

end
