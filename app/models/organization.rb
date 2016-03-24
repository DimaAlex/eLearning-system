class Organization < ActiveRecord::Base
  has_many :users_organizations, class_name: 'UsersOrganization'
  has_many :users, through: :users_organizations

  scope :org_admins, ->  {}
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def org_admins
    org_users = self.users_organizations.where(is_org_admin: true)
    org_admins = []
    org_users.each do |ou|
      org_admins += User.where(id: ou.user_id)
    end

    org_admins
  end

  def users_in_org
    org_users = self.users_organizations.where(is_org_admin: false)
    users = []
    org_users.each do |ou|
      users += User.where(id: ou.user_id)
    end

    users
  end

end
