class User < ActiveRecord::Base
  require 'csv'

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courses, as: :author

  has_many :users_organizations, class_name: 'UsersOrganization', dependent: :destroy
  has_many :invitations, :class_name => 'User', :as => :invited_by
  has_many :organizations, through: :users_organizations
  has_many :certificates

  has_many :input_user_answers
  has_many :users_courses
  has_many :courses, through: :users_courses

  accepts_nested_attributes_for :input_user_answers, allow_destroy: true
  scope :org_admins, -> { joins(:users_organizations).where('users_organizations.is_org_admin  = ?', true).distinct }
  scope :not_org_admins, -> { joins(:users_organizations).where('users_organizations.is_org_admin  = ?', false).distinct  }
  scope :invited_users, -> { joins(:users_organizations).where('users_organizations.state  = ?', :invited) }
  scope :followed_users, -> { joins(:users_organizations).where('users_organizations.state  = ?', :followed) }
  scope :in_organization, -> { joins(:users_organizations).where('users_organizations.state  = ?', :in_organization) }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "38x38>", avatar:"20x20" }, default_url: ":style/missing_avatar.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  acts_as_messageable

  has_many :admins_impersonations, foreign_key: "admin_id", dependent: :destroy

  def mailboxer_email(object)
    self.email
  end

  def self.import(file, organization)
    CSV.foreach(file.path) do |email|
      if EmailValidator.valid?(email.first)
        user = User.find_by_email(email.first)
        if user
          UserMailer.invitation_instractions(user.email, organization).deliver_later
        else
          User.invite!(email: email.first, users_organizations: [ UsersOrganization.new(organization_id: organization.id, state: :invited)])
        end
      end

      if organization.users.exclude?(user)
        organization.users_organizations.create(user_id: User.find_by_email(email.first).id, state: :invited)
      end
    end
  end

  def progress(course)
    user_course = users_courses.find_by_course_id(course.id)
    user_course_pages_passed = user_course.users_courses_pages.count
    all_course_pages = course.pages.count
    progress = (100 * user_course_pages_passed / all_course_pages) if all_course_pages!=0
    check_finish(user_course, progress)
  end

  def check_finish(user_course, progress)
    if progress == 100
      user_course.is_started = false
      user_course.is_finished = true
      user_course.save
    end
    progress
  end

  def course_finished?(course)
    user_course = users_courses.find_by_course_id(course.id)
    user_course.is_finished
  end

  def courses_with_status(status)
    courses_with_st = users_courses.where("#{status}=?", true).sort_by(&:updated_at).reverse.map {|x| x.course}
    if status == "is_started" || status == "is_liked"
      courses_with_st.map {|x| x if x.is_destroyed == false}.compact
    else
      courses_with_st
    end
  end

  def passed_pages_ids(course)
    users_courses.find_by_course_id(course.id).users_courses_pages.pluck(:page_id)
  end

  def member_of_organization?(organization)
    organizations.include?(organization)
  end

  def courses
    Course.where(is_destroyed: false)
  end
end
