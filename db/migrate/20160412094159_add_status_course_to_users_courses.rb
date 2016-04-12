class AddStatusCourseToUsersCourses < ActiveRecord::Migration
  def change
    add_column :users_courses, :status_course, :string, default: "In Progress"
  end
end
