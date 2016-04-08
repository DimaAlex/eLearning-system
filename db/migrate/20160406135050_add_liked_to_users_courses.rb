class AddLikedToUsersCourses < ActiveRecord::Migration
  def change
    add_column :users_courses, :is_liked, :boolean
  end
end
