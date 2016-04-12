class OrganizationsController < ApplicationController
  before_action :set_organization, except: [:index, :new, :create]

  authorize_resource except: [:index, :show, :report]

  def index
    @organizations = Organization.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    if can? :manage, Organization
      @organization = Organization.new
    else
      redirect_to organizations_path, alert: "You can't do this."
    end
  end

  def edit
    redirect_to organization_path(@organization), alert: "You can't do this." if cannot? :write, @organization
  end

  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
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
    @users_not_in_org = User.all - @organization.users
    @users_in_org = @organization.users.usual_users_in_org.paginate(page: params[:page], per_page: 20)
  end

  def courses_in_org
    @courses = @organization.courses.paginate(page: params[:page], per_page: 4)
  end

  def report
    @user = current_user
    if @organization.is_org_admin?(@user)
      @courses = @organization.courses
    else
      flash[:danger] =  "You have no access to report of this organization"
      redirect_to organization_path(@organization)
    end
  end

  private
  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:title, :description, :adress, :phone, :image)
  end

end
