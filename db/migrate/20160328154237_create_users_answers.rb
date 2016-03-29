class CreateUsersAnswers < ActiveRecord::Migration
  def change
    create_table :users_answers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :answer, index: true
    end
  end
end
