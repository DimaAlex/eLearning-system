class Course < ActiveRecord::Base
  belongs_to :author, polymorphic: true
  has_many :pages
  validates :title, presence: true, allow_blank: false

  searchkick autocomplete: ['title']

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/:style/missing_course.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
