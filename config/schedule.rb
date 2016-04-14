set :environment, 'development'
set :output, 'log/cron_log.log'

every 1.day do
  rake 'delete_users'
end

every 1.week do
  rake 'recommended_courses'
end