# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :white_list do
    email { Faker::Internet::email }
  end
end
