require 'rails_helper'

describe StoryAttachment do
  it { is_expected.to belong_to :story }
  it { is_expected.to validate_presence_of :photo }
  it { is_expected.to validate_presence_of :story }
end
