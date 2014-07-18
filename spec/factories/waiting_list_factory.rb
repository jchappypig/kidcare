FactoryGirl.define do
  factory :waiting_list do
    child_name Faker::Name.name
    child_age Faker::Number.number(1)
    parent_name Faker::Name.name
    phone Faker::PhoneNumber.cell_phone
    address Faker::Address.street_address
    postcode Faker::Address.postcode
    expect_join_time %w(ASAP Later).sample
    days_per_week %w(1 2 5)
  end
end
