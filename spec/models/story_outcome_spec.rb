require 'rails_helper'

describe StoryOutcome do
  it { is_expected.to belong_to :story }
  it { is_expected.to belong_to :outcome }
end
