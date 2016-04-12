desc 'Delete users that ignore inviting'
task delete_users: :environment do
  puts 'Delete users'
  DeleteUsersWorker.new.perform
  puts 'done.'
end