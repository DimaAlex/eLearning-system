class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courses, as: :author

  has_many :users_organizations
  has_many :organizations, through: :users_organizations

  acts_as_messageable

  def mailboxer_email(object)
    self.email
  end
end
