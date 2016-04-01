class InputUserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :page

  def check_answer(user)
    page = Page.find(page_id)
    right_answer = page.answers.find_by_is_right(true)
    if user_answer_body == right_answer.answer_body
      self.answer_id = right_answer.id
      self.save
    end
  end
end
