class Page < ActiveRecord::Base
  belongs_to :course
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  validates :title, presence: true, allow_blank: false
end
