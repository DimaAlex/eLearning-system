module UserHelper
  def user_has_impersonations?
    User.org_admins.include?(current_user) || current_user.is_admin
  end
end
