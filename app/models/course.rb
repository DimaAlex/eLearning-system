class Course < ActiveRecord::Base
  belongs_to :author, polymorphic: true
  has_many :pages
  has_one :certificate

  validates :title, presence: true, allow_blank: false
  has_many :users_courses
  has_many :users, through: :users_courses

  searchkick autocomplete: ['title']

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/:style/missing_course.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_attached_file :certificate_template,
                    :path => ":rails_root/public/system/courses/:attachment/000/000/0:id/:style/:normalized_video_file_name",
                    :url => "/system/:attachment/:id/:style/:normalized_video_file_name",
                    :default_url => ":rails_root/public/system/test_form.pdf"

  Paperclip.interpolates :normalized_video_file_name do |attachment, style|
    attachment.instance.normalized_video_file_name
  end

  def normalized_video_file_name
    "test_form.pdf"
  end

  validates_attachment :certificate_template, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }

end
