module UserHelper
  def is_admin?
    User.org_admins.include?(current_user) || current_user.is_admin
  end
end
