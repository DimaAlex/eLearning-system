class UsersCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :users_courses_pages
  has_many :pages, through: :users_courses_pages

  def self.started_courses
    user_course_count = UsersCourse.all.count
    user_started_courses = UsersCourse.where(mark: nil).count
    if user_course_count == 0
      0
    else
      user_started_courses.to_f / user_course_count.to_f * 100
    end
  end

  def self.success_finished_courses
    user_course_count = UsersCourse.all.count
    user_started_courses = UsersCourse.where(mark: 90..100).count
    if user_course_count == 0
      0
    else
      user_started_courses.to_f / user_course_count.to_f * 100
    end
  end

  def self.unsuccess_finished_courses
    user_course_count = UsersCourse.all.count
    user_started_courses = UsersCourse.where(mark: 0...90).count
    if user_course_count == 0
      0
    else
      user_started_courses.to_f / user_course_count.to_f * 100
    end
  end

end


