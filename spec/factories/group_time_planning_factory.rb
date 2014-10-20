include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :group_time_planning do
    association :weekly_program
    day { %w(Monday Tuesday Wednesday Thursday Friday Alternatives).sample }
  end
end
