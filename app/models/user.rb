class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users_organizations, class_name: 'UsersOrganization'
  has_many :organizations, through: :users_organizations

  acts_as_messageable

  def mailboxer_email(object)
    self.email
  end
end
