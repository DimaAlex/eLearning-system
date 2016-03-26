class AddDefaultValueForIsAdminToUsers < ActiveRecord::Migration
  def up
    change_column :users, :is_admin, :boolean, default: false
  end

  def down
    remove_column :users, :is_admin, :boolean
    add_column :users, :is_admin, :boolean
  end
end
