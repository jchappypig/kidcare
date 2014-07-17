# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :staff do
    email Faker::Internet::email
    password Faker::Internet::password(min_length=8, max_length=128)
  end
end
