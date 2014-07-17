# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :waiting_list do
    child_name "MyString"
    child_age 1
    parent_name "MyString"
    phone "MyString"
    address "MyString"
    postcode "MyString"
    expect_join_time "MyString"
    days_per_week "MyString"
  end
end
