class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :update]
  before_action :set_course, only: [:index,:create, :edit, :start_course]

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
    if @page.page_type == "Question" && @page.answers.first.answer_type == "Input"
      Answer.create(page_id: @page.id, is_right: false)
    end
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
