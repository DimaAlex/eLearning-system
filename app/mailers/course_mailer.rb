class CourseMailer < ApplicationMailer
  def recommended_courses(courses)
    @courses = courses
    # User.all.each do |u|
    #   mail(to: u.email, subject: 'Recommended courses at this week.')
    # end
    mail(to: User.last.email, subject: 'Recommended courses at this week.')
  end

end