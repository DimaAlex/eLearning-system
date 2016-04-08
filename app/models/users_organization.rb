class UsersOrganization < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :organization

  aasm :invite, column: :state do
    state :no, initial: true
    state :followed
    state :invited
    state :rejected
    state :in_organization
    state :leaved

    event :accept do
      transitions :from => :invited, :to => :in_organization
      transitions :from => :followed, :to => :in_organization
    end

    event :reject do
      transitions :from => :invited, :to => :rejected
      transitions :from => :followed, :to => :rejected
    end

    event :leave do
      transitions :from => :in_organization, :to => :leaved
    end
  end

end