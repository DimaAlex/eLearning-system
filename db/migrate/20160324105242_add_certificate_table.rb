class AddCertificateTable < ActiveRecord::Migration
  def change
    create_table(:certificates) do |t|
      t.integer :type
      t.belongs_to :сourses, index: true
      t.belongs_to :users, index: true
      t.timestamps null: false
    end
  end
end
