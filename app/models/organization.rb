class Organization < ActiveRecord::Base
  has_many :users_organizations
  has_many :users, through: :users_organizations
end
