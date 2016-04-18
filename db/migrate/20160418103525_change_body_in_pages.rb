class ChangeBodyInPages < ActiveRecord::Migration
   def up
    change_column :pages, :body, :text
  end

  def down
    change_column :pages, :body, :string
  end
end
