class Answer < ActiveRecord::Base
  belongs_to :page
  has_many :users_answers
  has_many :users, :through => :users_answers
end
