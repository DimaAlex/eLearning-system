class Course < ActiveRecord::Base
  belongs_to :author, polymorphic: true
  has_many :pages
  validates :title, presence: true, allow_blank: false
end
