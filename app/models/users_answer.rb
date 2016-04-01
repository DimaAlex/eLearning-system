class UsersAnswer < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user
  validates_presence_of :user
  validates_presence_of :answer

  accepts_nested_attributes_for :answer
end
