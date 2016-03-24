class RemoveAdressFromOrganizations < ActiveRecord::Migration
  def change
    remove_column :organizations, :adress, :string
  end
end
