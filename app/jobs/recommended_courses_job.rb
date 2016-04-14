class RecommendedCoursesJob < ActiveJob::Base
  queue_as :default

  def perform()
    CourseMailer.recommended_courses(Course.where(id: courses_ids)).deliver_later
  end
end