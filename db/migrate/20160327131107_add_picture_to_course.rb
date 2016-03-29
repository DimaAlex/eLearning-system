class AddPictureToCourse < ActiveRecord::Migration
  def up
    add_attachment :courses, :image
  end

  def down
    remove_attachment :courses, :image
  end
end
