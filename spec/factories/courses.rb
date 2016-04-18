require 'faker'

FactoryGirl.define do
  factory :course do
    title { Faker::Name.first_name }
    is_destroyed { false }
  end

end