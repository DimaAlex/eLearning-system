class CourseMailer < ApplicationMailer
  def recommended_courses(courses_ids)
    @courses = Course.where(id: courses_ids)
    User.all.each do |u|
      mail(to: u.email, subject: 'Recommended courses at this week.')
    end
  end

end