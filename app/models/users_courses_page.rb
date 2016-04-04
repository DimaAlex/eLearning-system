class UsersCoursesPage < ActiveRecord::Base
  belongs_to :page
  belongs_to :users_course
end
