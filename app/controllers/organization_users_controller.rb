class OrganizationUsersController < ApplicationController
  before_action :set_organization

  def add_users_to_org
    if can? :write, @organization
      @users_not_in_org = User.all - @organization.users
    else
      redirect_to organization_path(@organization), notice: "You can't do this."
    end
  end

  def add_org_admins_to_org
    if can? :write, @organization
      @users_without_admin = User.where(is_admin: false) - @organization.users.org_admins
    else
      redirect_to organization_path(@organization), notice: "You can't do this."
    end
  end

  def create_users_in_org
    @users = User.where(id: params.require(:organization).permit(users:[])[:users])

    @organization.users << @users
    @users.each { |user| UserMailer.invitation_instractions(user, @organization).deliver_later }

    redirect_to organization_path(@organization), notice: 'Users added.'
  end

  def create_org_admins_in_org
    @org_admins = User.where(id: params.require(:organization).permit(users:[])[:users])

    @org_admins.each do |org_admin|
      oa = @organization.users_organizations.build(user_id: org_admin.id, is_org_admin: true)
      oa.save
    end

    redirect_to organization_path(@organization)
  end

  def users_in_org
    if can? :write, @organization
      @users_in_org = @organization.users.usual_users_in_org.paginate(:page => params[:page], :per_page => 20)
    else
      redirect_to organization_path(@organization), notice: "You can't do this."
    end
  end

  def import_users_from_file
    begin
      User.import(params[:file], @organization)
      redirect_to organization_path(@organization), notice: 'Users added.'
    rescue
      redirect_to organization_path(@organization), notice: 'Invalid CSV file format.'
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end