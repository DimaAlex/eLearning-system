class AddAdressDescriptionPhoneToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :adress, :string
    add_column :organizations, :phone, :string
    add_column :organizations, :description, :string
  end
end
