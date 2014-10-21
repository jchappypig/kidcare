require 'rails_helper'

describe StoryAttachment do
  it { is_expected.to belong_to :story }
  it { is_expected.to validate_presence_of :photo }

  it 'should recruit orphan attachments after create' do
    story = create(:story)
    orphan_attachment = build(:story_attachment, story: nil, guid: story.guid)
    orphan_attachment.save
    expect(orphan_attachment.story).to eq(story)
  end
end
