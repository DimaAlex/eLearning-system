class AddDestroedToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :is_destroyed, :boolean, default: false
  end
end
