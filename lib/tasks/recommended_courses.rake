desc 'Email with recommended courses'
task recommended_courses: :environment do
  puts 'Send recommended courses'
  RecommendedCoursesJob.perform_later
  puts 'done.'
end