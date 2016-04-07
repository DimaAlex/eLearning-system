class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:new, :edit, :create, :destroy]
  before_action :set_user, only: [:show, :new]

  def index
    if params[:query].present?
      @courses = Course.search(params[:query])
    else
      @courses = Course.all
    end
  end

  def show
    @user = current_user
    @user_start_course = @user.users_courses.find_by_course_id(@course.id) if @user
    @user_start_course = @user_start_course.is_started if @user_start_course
    @user_finish_course = @user.users_courses.find_by_course_id(@course.id) if @user
    @user_finish_course = @user_finish_course.is_finished if @user_finish_course
    @user_estimation = @user.users_courses.find_by_course_id(@course.id) if @user
    @user_estimation = @user_estimation.estimation if @user_estimation
    if @user_start_course && !@course.can_pass?(@user)
      @progress = @user.progress(@course)
      @passed_pages_ids = @user.passed_pages_ids(@course)
    end
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
    if user_with_course.empty?
      @estimation = UsersCourse.new(user_course_params)
      @estimation.save
      redirect_to :back
    else
      user_with_course.first.update(estimation: params[:course][:estimation])
      redirect_to :back
    end
  end

  def course_result
    @user_certificate = User.find(params[:course][:user_id])
    @course_certificate = Course.find(params[:course][:course_id])
    pdf_source = TestPdfForm.new(@user_certificate, @course_certificate).export
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
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def autocomplete
    render json: Course.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end


  private

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
