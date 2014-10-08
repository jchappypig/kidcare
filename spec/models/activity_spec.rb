require 'rails_helper'

describe Activity do
  it {is_expected.to belong_to :weekly_program}
end
