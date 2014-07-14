FactoryGirl.define do
  factory :user do
    faker_password = Faker::Internet::password(min_length=8, max_length=128)
    email Faker::Internet::email
    password faker_password
    password_confirmation faker_password
  end
end
