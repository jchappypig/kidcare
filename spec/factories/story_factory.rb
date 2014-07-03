FactoryGirl.define do
  factory :story do
    title {Faker::Lorem.word}
    content {Faker::Lorem.paragraph}
    time_line Date.today
  end
end
