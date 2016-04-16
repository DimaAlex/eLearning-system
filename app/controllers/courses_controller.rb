class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:new, :edit, :create, :destroy]
  before_action :set_user, only: [:show, :new]

  def index
    if params[:query].present?
      @courses = Course.search(params[:query], page: params[:page], per_page: 3)
    elsif params[:type] == "public"
      @courses = Course.where(permission: 'Public').paginate(page: params[:page], per_page: 3)
    elsif params[:type] == "popular"
      @courses = Course.popular_courses.paginate(page: params[:page], per_page: 3)
    elsif params[:type] == "org"
      @courses = Course.where(permission: 'Public').where(author_type: "Organization").paginate(page: params[:page], per_page: 3)
    else
      @courses = []
    end
  end

  def show
    unless current_user
      redirect_to :back
      return
    end
      @user = current_user
      @mark = UsersCourse.where(user_id: current_user.id, course_id: @course.id)

      @user_start_course = @user.users_courses.find_by_course_id(@course.id) if @user
      if @user_start_course && !@course.is_author?(@user)
        @progress = @user.progress(@course)
        @passed_pages_ids = @user.passed_pages_ids(@course)
      end
      @is_liked = @user.users_courses.find_by_course_id(@course.id)
      @is_liked = @is_liked.is_liked if @is_liked
  end

  def new
    @course = Course.new
    @organizations_user_org_admin= @user.users_organizations.where(is_org_admin: true).map {|x| x.organization}
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    if @course.author_type == "User"
      @course.author = current_user
    end
    respond_to do |format|
      if @course.save
        if @course.permission == "Individual"
          format.html { redirect_to course_add_users_individual_course_path(@course), notice: 'Course was successfully created.' }
        else
        format.html { redirect_to course_pages_path(@course), notice: 'Course was successfully created.' }
        end
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_users_courses
    user_with_course = UsersCourse.where(user_id: params[:course][:user_id], course_id: params[:course][:course_id].to_i)

    percent = Course.percent(params[:course][:course_id], current_user)
    if percent >= 90
      status = "Success"
      check_certificate
    else
      status = "Unsuccess"
    end

    if user_with_course.empty?
      @estimation = UsersCourse.new(user_course_params)
      @estimation.save
      redirect_to :back
    else
      user_with_course.first.update(estimation: params[:course][:estimation], mark: percent.to_i, status_course: status)
      redirect_to :back
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course.is_destroyed  = true
    @course.pages.each {|x| x.answers.destroy_all}
    @course.pages.destroy_all
    if @course.save
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Course was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def autocomplete
    render json: Course.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end

  private

  def check_certificate
    @user_certificate = User.find(params[:course][:user_id])
    @course_certificate = Course.find(params[:course][:course_id])
    pdf_source = TestPdfForm.new(@user_certificate, @course_certificate).export
    @user_course = UsersCourse.where(user_id: params[:course][:user_id], course_id: params[:course][:course_id])
    @user_course.first.update(certificate: pdf_source)
  end

  def set_user
    @user = current_user
  end

  def check_user
    unless current_user
      flash[:danger] =  "You should log in"
      redirect_to root_path
    end
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :image, :permission, :certificate_template, :author_type, :author_id)
  end

  def user_course_params
    params.require(:course).permit(:user_id, :course_id, :estimation)
  end
end
