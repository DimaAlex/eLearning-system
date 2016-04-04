class Organization < ActiveRecord::Base
  has_many :users_organizations, class_name: 'UsersOrganization', dependent: :destroy
  has_many :users, through: :users_organizations

  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: ":style/no_org_image.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
