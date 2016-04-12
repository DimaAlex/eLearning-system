class DeleteUsersWorker
  def perform
    users = User.invitation_not_accepted
    users.each do |u|
      if u.created_at < (Time.now - 1.hour)
        u.destroy
      end
    end
  end
end