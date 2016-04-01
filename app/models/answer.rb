class Answer < ActiveRecord::Base
  belongs_to :page
  has_many :input_users_answers
  has_many :users, :through => :input_users_answers
end
