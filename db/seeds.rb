# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 15.times do |i|
#   user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "11111111", password_confirmation: "11111111")
# end
# User.all.each do |user|
#   user.country = Faker::Address.country
#   user.save
# end

# 20.times do |i|
#   organization = Organization.create(title: Faker::Company.name, phone: Faker::PhoneNumber.cell_phone, description: Faker::Lorem.paragraph(2))
#   organization.save
# end

# 20.times do |i|
#   imper = AdminsImpersonation.create(user_id: 1, admin_id: 31)
#   imper.save
# end

# 10.times do |i|
#   course = Course.create(title: Faker::Company.name,
#                          permission: "Public",
#                          author_id: 49,
#                          author_type: "User"
#                          )
#   course.save
# end

10.times do |i|
  course = Course.create(title: Faker::Company.name,
                         permission: "Public",
                         author_id: rand(78..81),
                         author_type: "User"
                         )
  page = Page.new(title: Faker::Company.name,
                     course_id: course.id,
                     page_type: "Lecture",
                     body: "Example")
  page.save
  course.save
end
10.times do |i|
  course = Course.create(title: Faker::Company.name,
                         permission: "Public",
                         author_id: rand(1..5),
                         author_type: "Organization"
                         )
  page = Page.new(title: Faker::Company.name,
                     course_id: course.id,
                     page_type: "Lecture",
                     body: "Example")
  page.save
  course.save
end
