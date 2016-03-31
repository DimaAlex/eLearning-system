class AddFieldToInputUsersAnswers < ActiveRecord::Migration
  def change
    add_reference :input_user_answers, :answer, index: true
  end
end
