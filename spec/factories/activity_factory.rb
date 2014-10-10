include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :activity do
    association :weekly_program
    category { %w(Indoor Outdoor).sample }
    day { %w(Monday Tuesday Wednesday Thursday Friday).sample }
  end
end
