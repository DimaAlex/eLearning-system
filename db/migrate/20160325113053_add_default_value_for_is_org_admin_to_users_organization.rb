class AddDefaultValueForIsOrgAdminToUsersOrganization < ActiveRecord::Migration
  def up
    change_column :users_organizations, :is_org_admin, :boolean, default: false
  end

  def down
    remove_column :users_organizations, :is_org_admin, :boolean
    add_column :users_organizations, :is_org_admin, :boolean
  end
end
