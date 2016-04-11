class AddCertificateToUsersCourses < ActiveRecord::Migration
  def change
    add_column :users_courses, :certificate, :string
  end
end
