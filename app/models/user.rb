class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courses, as: :author

  acts_as_messageable

  def mailboxer_email(object)
    self.email
  end
end
