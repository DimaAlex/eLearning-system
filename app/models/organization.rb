class Organization < ActiveRecord::Base
  has_many :users_organizations, class_name: 'UsersOrganization', dependent: :destroy
  has_many :users, through: :users_organizations
  has_many :courses, as: :author
  validates :title, presence: true, allow_blank: false

  has_attached_file :image, styles: { medium: "300x300>", thumb: "145x145>" }, default_url: ":style/no_org_image.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  searchkick autocomplete: ['title']

  def is_org_admin?(user)
    unless user.nil?
      return users_organizations.where(is_org_admin: true).pluck(:user_id).include?(user.id)
    end
    false
  end

  def courses
    Course.where(author: self, is_destroyed: false)
  end

  def percent_of_users_in_org_start(course)
    all_users_without_admins = users_organizations.where(is_org_admin: false).count
    users_start = course.users_courses.where(is_started: true)
    users_start << course.users_courses.where(is_finished: true)
    all_users_without_admins != 0 ? (users_start.count * 100 / all_users_without_admins) : 0
  end

end
