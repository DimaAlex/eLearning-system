module UserHelper
  def is_admin?
    User.org_admins.include?(current_user) || current_user.is_admin
  end

  def user_invited?(organization)
    organization.users.invited_users.include?(current_user)
  end

  def user_in_organization?(organization)
    organization.users.in_organization.include?(current_user)
  end
end
