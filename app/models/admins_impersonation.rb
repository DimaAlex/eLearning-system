class AdminsImpersonation < ActiveRecord::Base
  belongs_to :user

  scope :ordered, -> { order('begin_impersonation DESC') }
end
