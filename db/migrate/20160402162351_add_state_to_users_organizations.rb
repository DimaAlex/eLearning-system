class AddStateToUsersOrganizations < ActiveRecord::Migration
  def change
    add_column :users_organizations, :state, :string
  end
end
