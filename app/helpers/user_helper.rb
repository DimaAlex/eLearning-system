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

  def can_follow?(organization)
     !current_user.nil? && !current_user.is_admin && !organization.users.include?(current_user)
  end

  def state(user, organization)
    user.users_organizations.find_by_organization_id(organization.id)
  end
end
