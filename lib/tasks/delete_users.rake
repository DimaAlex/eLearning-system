desc 'Delete users that ignore inviting'
task delete_users: :environment do
  puts 'Delete users'
  DeleteUsersJob.perform_later
  puts 'done.'
end