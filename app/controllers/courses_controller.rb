class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :start_course]
  before_action :check_user, only: [:new, :edit, :create, :destroy, :start_course]

  def index
    if params[:query].present?
      @courses = Course.search(params[:query])
    else
      @courses = Course.all
    end
  end

  def show
    @user = current_user
    @user_start_course = @user.courses.include?(@course) if @user
    if @user_start_course
      @progress = @user.progress(@course)
      @passed_pages_ids = @user.passed_pages_ids(@course)
    end
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    @course.author = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_pages_path(@course), notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new}
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
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
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def autocomplete
    render json: Course.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end

  def start_course
    @user = current_user
    user_course = UsersCourse.new(user_id: @user.id, course_id: @course.id)
    if user_course.save
      flash[:success] =  "Course is started"
    else
      flash[:success] =  "Course is not started"
    end
    redirect_to course_path
  end

  private

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
      params.require(:course).permit(:title, :image, :permission, :certificate_template)
    end
end
