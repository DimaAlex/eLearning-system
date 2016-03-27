class AddPageToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :page, index: true
  end
end
