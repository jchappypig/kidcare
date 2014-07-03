require 'rails_helper'

describe Story do
  it {is_expected.to have_many :story_attachment}
  it {is_expected.to validate_presence_of :content}
end