class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_admin
      can :manage, :all
      cannot :follow, Organization
    else
      can :read, Organization
      can :write, Organization, id: UsersOrganization.where(user_id: user.id, is_org_admin: true).pluck(:organization_id)
    end

  end
end
