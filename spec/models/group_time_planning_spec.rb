require 'rails_helper'

describe GroupTimePlanning do
  it {is_expected.to belong_to :weekly_program}
  it {is_expected.to validate_presence_of(:day)}
end
