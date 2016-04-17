class UsersCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :users_courses_pages
  has_many :pages, through: :users_courses_pages

  MAX_BADLY_MARK = 89
  MIN_ACCESS_MARK = 90

  def self.unsuccess_finished_courses
    UsersCourse.where(mark: 0..MAX_BADLY_MARK)
  end

  def self.success_finished_courses
    UsersCourse.where(mark: MIN_ACCESS_MARK..100)
  end
end


