class DeleteUsersAnswers < ActiveRecord::Migration
  def change
    drop_table :users_answers
  end
end
