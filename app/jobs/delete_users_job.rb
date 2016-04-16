class DeleteUsersJob < ActiveJob::Base
  queue_as :default

  def perform
    users = User.invitation_not_accepted
    users.each do |u|
      if u.created_at < (Time.now - 2.weeks)
        u.destroy
      end
    end
  end
end