class AddEstimationToUsersCourses < ActiveRecord::Migration
  def change
    add_column :users_courses, :estimation, :integer
  end
end
