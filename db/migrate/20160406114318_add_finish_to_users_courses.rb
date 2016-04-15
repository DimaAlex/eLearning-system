class AddFinishToUsersCourses < ActiveRecord::Migration
  def change
    add_column :users_courses, :is_finished, :boolean
  end
end
