class Organization < ActiveRecord::Base
  has_many :users_organizations, class_name: 'UsersOrganization', dependent: :destroy
  has_many :users, through: :users_organizations
  has_many :courses, as: :author
  validates :title, presence: true, allow_blank: false

  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: ":style/no_org_image.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def is_org_admin?(user)
    users_organizations.where(is_org_admin: true).pluck(:user_id).include?(user.id)
  end

  def courses
    courses = Course.where(author_type: "Organization")
    courses.where(author_id: self.id)
  end

  def proceent_of_users_in_org_start(course)
    all_users = users.count
    users_start = course.users_courses.where(is_started: true)
    users_start << course.users_courses.where(is_finished: true)
    users_start.count * 100 / all_users if all_users
  end
end
