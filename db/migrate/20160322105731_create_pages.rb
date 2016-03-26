class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.belongs_to :course, index: true
      t.string :title
      t.string :page_type
      t.string :body
      t.timestamps null: false
    end
  end
end
