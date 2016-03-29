class OrganizationsController < ApplicationController
  before_action :set_organization, except: [:index, :new, :create]
  before_action :set_org_admins, only: [:create, :update, :create_users_to_org]
  before_action :all_users_without_admin, only:  [:new, :edit]

  authorize_resource except: [:index, :show]

  def index
    @organizations = Organization.paginate(page: params[:page], per_page: 5)
    @organization = Organization.new

  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

  def create
    @organization = Organization.new(organization_params)
    @users.each do |org_admin|
      @organization.users_organizations.build(user_id: org_admin.id, is_org_admin: true)
    end

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @users.each do |org_admin|
      @organization.users_organizations.build(user_id: org_admin.id, is_org_admin: true)
    end

    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
    end
  end

  def users_in_org
    @users = User.all - @organization.users
  end

  def create_users_to_org
    @organization.users << @users

    redirect_to organization_all_users_path(@organization)
  end

  def import
    begin
      User.import(params[:file])
      redirect_to organization_all_users_path(@organization)
    rescue
      redirect_to organization_all_users_path(@organization), notice: 'Invalid CSV file format.'
    end
  end

  private
  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:title, :description, :adress, :phone, :image)
  end

  def set_org_admins
    @users = User.where(id: params.require(:organization).permit(users:[])[:users])
  end

  def all_users_without_admin
    @users_without_admin = User.where(is_admin: false)
  end

end
