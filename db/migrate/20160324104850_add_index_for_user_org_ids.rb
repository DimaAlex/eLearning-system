class AddIndexForUserOrgIds < ActiveRecord::Migration
  def change
    add_index :users_organizations, [:user_id, :organization_id], unique: true
  end
end
