class Organization < ActiveRecord::Base
  has_many :users_organizations, class_name: 'UsersOrganization'
  has_many :users, through: :users_organizations

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def org_admins

  end

end
