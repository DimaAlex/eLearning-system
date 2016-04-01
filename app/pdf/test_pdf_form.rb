class TestPdfForm < FillablePdfForm

  def initialize(user, course = Course.last)
    @user = user
    @course = course
    super()
  end

  protected

  def fill_out
    fill :date, Date.today.strftime("%B %d, %Y")
    fill :course_title, @course.title
    fill :first_name, @user.first_name
    fill :last_name, @user.last_name
    fill :author, "#{@course.author.first_name} #{@course.author.last_name}"
  end
end