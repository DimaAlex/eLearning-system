class CreateUsersCoursesPages < ActiveRecord::Migration
  def change
    create_table :users_courses_pages do |t|
      t.belongs_to :users_course, index: true
      t.belongs_to :page, index: true
      t.timestamps null: false
    end
  end
end
