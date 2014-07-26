require 'rails_helper'

describe WhiteList do
  it { is_expected.to validate_presence_of :email }
end
