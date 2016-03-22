class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.where(course_id: params[:course_id])
  end

  def show
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @course = Course.find(params[:course_id])
    @page = @course.pages.build(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to course_pages_path, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: course_pages_path }
      else
        format.html { render :new}
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_course
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :page_type, :body)
  end
end
