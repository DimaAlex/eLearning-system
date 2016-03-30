class UsersCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :users_courses_pages
  has_many :pages, through: :users_courses_pages
end
