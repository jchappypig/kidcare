FactoryGirl.define do
  factory :story do
    content {Faker::Lorem.paragraph}
    time_line Date.today
    guid SecureRandom.uuid

    factory :story_with_attachments do
      ignore do
        attachments_count 1
      end

      after(:create) do |story, evaluator|
        create_list(:story_attachment, evaluator.attachments_count, story: story)
      end
    end
  end
end
