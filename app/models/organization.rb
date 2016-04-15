class Organization < ActiveRecord::Base
  has_many :users_organizations, class_name: 'UsersOrganization', dependent: :destroy
  has_many :users, through: :users_organizations
  has_many :courses, as: :author
  validates :title, presence: true, allow_blank: false

  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: ":style/no_org_image.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def is_org_admin?(user)
    unless user.nil?
      return users_organizations.where(is_org_admin: true).pluck(:user_id).include?(user.id)
    end
    false
  end

  def courses
    Course.where(author: self, is_destroyed: false)
  end

  def proceent_of_users_in_org_start(course)
    all_users_without_admins = users_organizations.where(is_org_admin: false).count
    users_start = course.users_courses.where(is_started: true)
    users_start << course.users_courses.where(is_finished: true)
    all_users_without_admins != 0 ? (users_start.count * 100 / all_users_without_admins) : 0
  end

  def started_courses
    started_courses_count = courses.map {|x| x.users_courses.where(is_started: true).count}.sum
    count_percent(started_courses_count)
  end

  def success_finished_courses
    success_count = courses.map {|x| x.users_courses.where(mark: 90..100).count}.sum
    count_percent(success_count)
  end

  def unsuccess_finished_courses
    unsuccess_count = courses.map {|x| x.users_courses.where(mark: 0..89).count}.sum
    count_percent(unsuccess_count)
  end

  def count_percent(sum)
    courses.count == 0 ? sum.to_f / courses.count.to_f * 100 : 0
  end
end
