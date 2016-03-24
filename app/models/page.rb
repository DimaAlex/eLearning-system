class Page < ActiveRecord::Base
  belongs_to :course
  has_many :answers
  validates :title, presence: true, allow_blank: false
end
