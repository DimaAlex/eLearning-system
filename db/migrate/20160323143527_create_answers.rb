class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :page, index: true
      t.string :answer_type
      t.boolean :is_right, default: false
    end
  end
end
