class AddMarkToUserCourses < ActiveRecord::Migration
  def change
    add_column :users_courses, :mark, :integer
  end
end
