class AddFieldToUsersCourses < ActiveRecord::Migration
  def change
    add_column :users_courses, :is_started, :boolean
  end
end
