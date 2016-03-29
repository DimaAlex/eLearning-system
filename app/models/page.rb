class Page < ActiveRecord::Base
  belongs_to :course
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  validates :title, presence: true, allow_blank: false
  validates :body, presence: true, on: :update, if: :page_type_lecture?
  validates :body, presence: true, on: :create, if: :page_type_question?
  validates_format_of :body, with: /https:\/\/www\.youtube\.com\/watch\?v=([a-zA-Z0-9_-]*)/,
                      on: :update,
                      if: :page_type_video?

  def page_type_question?
    @answer_type = answers.first.answer_type
    page_type == "Question" && (@answer_type == "Radio" || @answer_type == "Checkbox")
  end

  def page_type_video?
    page_type == "Video"
  end

  def page_type_lecture?
    page_type == "Lecture"
  end

  def next_page
    course = self.course
    index = course.pages.index(self)
    if (course.pages.count - 1)!=index
      course.pages[index + 1]
    end
  end

end
