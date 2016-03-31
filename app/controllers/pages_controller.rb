class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :update, :finish_page, :check_user]
  before_action :set_course, only: [:index,:create, :edit, :finish_page]
  before_action :check_user, only: [:show, :edit]

  def index
    @pages = Page.where(course_id: params[:course_id])
    @page = Page.new
    @page.answers.build
  end

  def show
    @pages = Page.where(course_id: params[:course_id])
    @user = current_user
    @input_user_answer = @user.input_user_answers.find_by_page_id(@page.id)
    @input_user_answer ||= @user.input_user_answers.build
    @progress = @user.progress(@page.course)
  end

  def new
    @page = Page.new
  end

  def edit
    @answer_type = @page.answers.first.answer_type
    if @page.page_type == "Question" && (@answer_type == "Radio" || @answer_type == "Checkbox")
      (@page.body.to_i-1).times { @page.answers.build }
    end
  end

  def create
    @page = @course.pages.build(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to edit_course_page_path(id: @page.id) }
        format.json { render :show, status: :created, location: course_pages_path }
      else
        format.html { redirect_to course_pages_path }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @page.update(page_params)
      redirect_to course_pages_path
    else
      redirect_to edit_course_page_path(id: @page.id)
    end
  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def finish_page
    @user = current_user
    users_course = @user.users_courses.find_by_course_id(@course.id)
    users_courses_page = users_course.users_courses_pages.find_by_page_id(@page.id)
    users_courses_page ||= UsersCoursesPage.new(users_course_id: users_course.id, page_id: @page.id)
    if users_courses_page.save
      next_page = @page.next_page
      if @page && next_page
        redirect_to course_page_path(course_id: @page.course.id, id: next_page.id)
      else
        redirect_to course_url(@page.course)
      end
    end
  end

  private

  def check_user
    @user = current_user
    if @user
      @user_start_course = @user.courses.include?(@page.course)
      unless @user_start_course || @page.course.author == @user
        flash[:danger] = "You should start course to see page"
        redirect_to course_path(@page.course)
      end
    else
      flash[:danger] = "You should log in"
      redirect_to root_path
    end
  end

  def set_page
    @page = Page.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def page_params
    params.require(:page).permit(:title, :page_type, :body,
                                 answers_attributes: [:id, :page_id, :answer_type, :answer_body, :is_right])
  end
end
