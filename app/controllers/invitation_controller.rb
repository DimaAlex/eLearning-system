class InvitationController < ApplicationController
  def accept_on_invite
    uo = UsersOrganization.where(user_id: current_user.id, organization_id: current_organization.id).distinct
    uo.first.accept!

    redirect_to organization_path(current_organization)
  end

  def reject_on_invite
    uo = UsersOrganization.where(user_id: current_user.id, organization_id: current_organization.id).distinct
    uo.first.reject!

    redirect_to organization_path(current_organization)
  end

  def follow_on_organization
    uo = UsersOrganization.new(user_id: current_user.id, organization_id: current_organization.id, state: :followed)
    if uo.save
      redirect_to organization_path(current_organization)
    else
      redirect_to organization_path(current_organization), alert: 'You were not follow on organization.'
    end
  end

  def leave_organization
    uo = UsersOrganization.where(user_id: current_user.id, organization_id: current_organization.id).distinct
    if uo.first.leave!
      redirect_to organization_path(current_organization), notice: 'You left organization.'
    else
      redirect_to organization_path(current_organization), alert: 'Something go wrong.'
    end
  end

  private

  def current_organization
    Organization.find(params[:organization_id])
  end
end