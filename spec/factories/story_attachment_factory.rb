include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :story_attachment do
    association :story, strategy: :build
    photo { fixture_file_upload 'app/assets/images/test.png', 'image/png' }
  end
end
