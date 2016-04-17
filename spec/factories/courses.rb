require 'faker'

FactoryGirl.define do
  factory :course do
    title { Faker::Name.first_name }
  end

end