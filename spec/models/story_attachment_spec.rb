require 'rails_helper'

describe StoryAttachment do
  it { is_expected.to belong_to :story }
end
