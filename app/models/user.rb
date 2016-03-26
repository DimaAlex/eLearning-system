class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courses, as: :author

  has_many :users_organizations, class_name: 'UsersOrganization'
  has_many :organizations, through: :users_organizations
  has_many :certificates

  scope :org_admins, -> { joins(:users_organizations).where('users_organizations.is_org_admin  = ?', true) }
  scope :usual_users_in_org, -> { joins(:users_organizations).where('users_organizations.is_org_admin  = ?', false) }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "38x38>" }, default_url: ":style/missing_avatar.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  acts_as_messageable

  def mailboxer_email(object)
    self.email
  end
end
