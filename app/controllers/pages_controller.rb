class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :update]

  def index
    @pages = Page.where(course_id: params[:course_id])
    @page = Page.new
  end

  def show
  end

  def new
    @page = Page.new
  end

  def edit
    @course = Course.find(params[:course_id])
  end

  def create
    @course = Course.find(params[:course_id])
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

  private
  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :page_type, :body,
                                 answer_attributes: [:page_id,:answer_type, :answer_body, :is_right],)
  end
end
