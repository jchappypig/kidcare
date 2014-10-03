FactoryGirl.define do
  factory :weekly_program do
    week_start 1.days.ago
    program_staff { Faker::name }
    theme { Faker::Lorem.sentence }
    goals { Faker::Lorem.sentence }
    letter { Faker::Lorem.name.first }
    number { Faker::Number.digit }
    shape { Faker::Lorem.word }
  end
end
