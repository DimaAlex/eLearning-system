# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

60.times do
  User.create(first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               email: Faker::Internet.email,
               country:  Faker::Address.country,
               password: "11111111",
               password_confirmation: "11111111",
               avatar: Faker::Avatar.image
              )

end

20.times do
  Organization.create(title: Faker::Company.name,
                      phone: Faker::PhoneNumber.cell_phone,
                      description: Faker::Lorem.paragraph(15),
                      image: Faker::Avatar.image
                      )
end


20.times do
  course = Course.create(title: Faker::Company.name,
                         permission: "Public",
                         author_id: rand(User.first.id..User.last.id),
                         author_type: "User",
                         image: Faker::Avatar.image

                         )
  3.times do
    Page.create(title: Faker::Company.name,
                course_id: course.id,
                page_type: "Lecture",
                body: Faker::Lorem.paragraph(25)
                )
  end
  Page.create(title: Faker::Company.name,
              course_id: course.id,
              page_type: "Video",
              body: "https://www.youtube.com/watch?v=Dji9ALCgfpM"
                  )
  course.save
end

40.times do
  course = Course.create(title: Faker::Company.name,
                         permission: "Public",
                         author_id: rand(Organization.first.id..Organization.last.id),
                         author_type: "Organization",
                         image: Faker::Avatar.image
                         )
  3.times do
    Page.create(title: Faker::Company.name,
              course_id: course.id,
              page_type: "Lecture",
              body: Faker::Lorem.paragraph(25)
              )
  end
  Page.create(title: Faker::Company.name,
              course_id: course.id,
              page_type: "Video",
              body: "https://www.youtube.com/watch?v=Dji9ALCgfpM"
              )
  course.save
end
