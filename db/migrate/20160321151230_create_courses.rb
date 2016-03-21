class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :permission
      t.references :author, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
