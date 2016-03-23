class CreateUsersOrganizations < ActiveRecord::Migration
  def change
    create_table :users_organizations do |t|
      t.boolean :is_org_admin
      t.belongs_to :user, index: true
      t.belongs_to :organization, index: true
    end
  end
end
