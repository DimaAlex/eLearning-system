class InputUserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :page

  def check_answer(user)
    page = Page.find(page_id)
    right_answer = page.answers.find_by_is_right(true)
    user_answer = UsersAnswer.new(user_id: user.id)
      if user_answer_body == right_answer.answer_body
        user_answer.answer_id = right_answer.id
      else
        user_answer.answer_id = page.answers.find_by_is_right(false).id
      end
    user_answer.save
  end
end
