include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :story_attachment do
    guid { SecureRandom.uuid }
    ignore do
      another_photo false
    end

    association :story, strategy: :build
    photo { fixture_file_upload 'spec/images/' + "#{another_photo ? 'ball' : 'flower'}" + '.png', 'image/png' }
  end
end
