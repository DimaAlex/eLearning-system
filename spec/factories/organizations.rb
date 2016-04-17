require 'faker'

FactoryGirl.define do
  factory :organization do
    title { Faker::Company.name }
    description { Faker::Lorem.paragraph(2) }
    phone { Faker::PhoneNumber.cell_phone }
  end

end