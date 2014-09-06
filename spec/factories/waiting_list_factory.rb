FactoryGirl.define do
  factory :waiting_list do
    child_full_name Faker::Name.name
    child_dob 30.years.ago.to_date
    parent_full_name Faker::Name.name
    home_phone Faker::PhoneNumber.phone_number
    mobile_phone Faker::PhoneNumber.cell_phone
    address Faker::Address.street_address
    intend_start_date %w(ASAP Later).sample
    days_required %w(Monday Tuesday)
  end
end
