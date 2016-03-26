class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer_type
      t.boolean :is_right
      t.string :answer_body
      t.timestamps null: false
    end
  end
end
