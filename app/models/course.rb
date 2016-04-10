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

  def can_pass?(user)
    author == user || (author_type == "Organization" && author.is_org_admin?(user))
  end

  def self.percent(course_id, user)
    pages_id = Page.where(course_id: course_id, page_type: "Question")
    question_count = pages_id.count
    correct_answers_count = 0.0

    pages_id.each do |page|
      system_answer = Answer.where(page_id: page.id)

      input_user_answer = InputUserAnswer.where(page_id: page.id, user_id: user.id)

      case system_answer.first.answer_type
        when "Input"
          correct_answers_count += check_input
        when "Radio"
          correct_answers_count += check_radio(input_user_answer)
        else
          correct_answers_count += check_checkbox
      end
    end

    correct_answers_count / question_count * 100
  end

  def check_input
    
  end

  def self.check_radio(answer)
    result = Answer.find(answer.first.answer_id)
    if result.is_right
      1
    else
      0
    end
  end

  def check_checkbox

  end

end
