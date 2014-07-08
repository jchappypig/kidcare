require 'rails_helper'

describe Outcome do
  it { is_expected.to validate_presence_of :item_no }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to have_many :story_outcomes}
  # it { is_expected.to have_many :story}
end
