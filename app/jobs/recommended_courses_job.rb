class RecommendedCoursesJob < ActiveJob::Base
  queue_as :default

  def perform()
    courses_ids = Course.popular_courses.map {|c| c.id }
    CourseMailer.recommended_courses(courses_ids).deliver_later
  end
end