class Course < ActiveRecord::Base
  belongs_to :author, polymorphic: true
  has_many :pages
  has_one :certificate

  validates :title, presence: true, allow_blank: false
  has_many :users_courses
  has_many :users, through: :users_courses

  # searchkick autocomplete: ['title']

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing_course.jpg"
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

  def is_author?(user)
    author == user || (author_type == "Organization" && author.is_org_admin?(user))
  end

  def users_try_course
    users_courses.where("is_started", true).count +  users_courses.where("is_finished", true).count
  end

  def average_users_mark
    marks = users_courses.pluck(:mark)
    marks.compact.empty? ? 0 : marks.sum / marks.count.to_f
  end

  def self.popular_courses
    courses = Course.where(permission: 'Public', is_destroyed: false)
    courses = courses.sort_by {|x| x.users_courses.average(:estimation) ? x.users_courses.average(:estimation) : 0 }
    courses.reverse!.last(8)
  end

  def finished_with_success
    users_courses.where(mark: 90..100).count
  end

  def finished_badly
    users_courses.where(mark: 0..89).count
  end

  def self.percent(course_id, user)
    pages_id = Page.where(course_id: course_id, page_type: "Question")
    question_count = pages_id.count
    correct_answers_count = 0.0
    if question_count == 0
      100
    else
      pages_id.each do |page|
        system_answer = Answer.where(page_id: page.id)

        input_user_answer = InputUserAnswer.where(page_id: page.id, user_id: user.id)

        case system_answer.first.answer_type
          when "Input"
            correct_answers_count += check_input(input_user_answer)
          when "Radio"
            correct_answers_count += check_radio(input_user_answer)
          else
            correct_answers_count += check_checkbox(input_user_answer, page.id)
        end
      end
      correct_answers_count / question_count * 100
    end
  end

  def self.check_input(answer)
    (answer.first && answer.first.answer_id.nil?) ? 0 : 1
  end

  def self.check_radio(answer)
    result = Answer.find(answer.first.answer_id)
    if result.is_right
      1
    else
      0
    end
  end

  def self.check_checkbox(answer, page_id)

    tmp_system_answer = Answer.where(page_id: page_id, is_right: true)

    if tmp_system_answer.count != answer.count
      0
    else
      counter = 0
      tmp_system_answer.each_index do |index|
        if tmp_system_answer[index].id != answer[index].answer_id
          counter += 1
        end
      end
      if counter == 0
        1
      else
        0
      end
    end
  end

end
