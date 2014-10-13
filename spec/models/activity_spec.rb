require 'rails_helper'

describe Activity do
  it {is_expected.to belong_to :weekly_program}
  it {is_expected.to validate_presence_of(:category)}
  it {is_expected.to validate_presence_of(:day)}
  it {is_expected.to validate_presence_of(:weekly_program_id)}
end
