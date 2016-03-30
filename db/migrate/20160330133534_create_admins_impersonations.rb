class CreateAdminsImpersonations < ActiveRecord::Migration
  def change
    create_table :admins_impersonations do |t|
      t.integer :user_id
      t.integer :admin_id
      t.datetime :begin_impersonation
      t.datetime :end_impersonation
    end
  end
end
