class OrganizationUsersController < ApplicationController
  before_action :set_organization

  def add_users_to_org
    if can? :write, @organization
      @users_not_in_org = User.where(is_admin: false) - @organization.users
    else
      redirect_to organization_path(@organization), notice: "You can't do this."
    end
  end

  def add_org_admins_to_org
    if can? :write, @organization
      @users_without_admin = User.where(is_admin: false) - @organization.users.org_admins - User.invitation_not_accepted
    else
      redirect_to organization_path(@organization), notice: "You can't do this."
    end
  end

  def create_users_in_org
    users = User.where(id: params.require(:organization).permit(users:[])[:users])

    if users.empty?
      redirect_to organization_add_users_to_org_path(@organization), notice: 'There is no users to add in organization.'
    else
      uniq_users = users - @organization.users
      users_org = []

      uniq_users.each do |user|
        users_org << { user_id: user.id, state: :invited }
      end

      @organization.users_organizations.create(users_org)

      uniq_users.each do |user|
        UserMailer.invitation_instractions(user.email, @organization).deliver_later
      end

      redirect_to organization_path(@organization), notice: 'User(s) added.'
    end

  end

  def create_org_admins_in_org
    org_admins = User.where(id: params.require(:organization).permit(users:[])[:users])

    if org_admins.empty?
      redirect_to organization_add_org_admins_to_org_path(@organization), notice: 'There is no users to add.'
    else
      uniq_users = []
      org_admins.each do |admin|
        if @organization.users.include?(admin)
          uo = @organization.users_organizations.find_by_user_id(admin.id)
          uo.update_attributes(is_org_admin: true)
        else
          uniq_users << { user_id: admin.id, is_org_admin: true }
        end
      end

      @organization.users_organizations.create(uniq_users)

      redirect_to organization_path(@organization), notice: 'Admin(s) of organization added.'
    end

  end

  def users_in_org
    if can? :write, @organization
      @users_in_org = @organization.users.not_org_admins.paginate(:page => params[:page], :per_page => 20)
    else
      redirect_to organization_path(@organization), notice: "You can't do this."
    end
  end

  def import_users_from_file
    begin
      User.import(params[:file], @organization)
      redirect_to organization_path(@organization), notice: 'User(s) added.'
    rescue
      redirect_to organization_add_users_to_org_path(@organization), notice: 'Invalid CSV file format.'
    end
  end

  def delete_user
    uo = UsersOrganization.where(organization_id: @organization.id, user_id: params[:user_id]).limit(1)
    uo.first.destroy
    redirect_to action: :users_in_org
  end

  private

  def set_organization
    @organization = Organization.includes(:users).find(params[:organization_id])
  end
end