class CreateInputUserAnswers < ActiveRecord::Migration
  def change
    create_table :input_user_answers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :page, index: true
      t.string :user_answer_body
    end
  end
end
