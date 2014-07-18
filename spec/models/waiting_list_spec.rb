require 'rails_helper'

describe WaitingList do
  it { is_expected.to validate_presence_of :child_name }
  it { is_expected.to validate_presence_of :child_age }
  it { is_expected.to validate_presence_of :parent_name }
  it { is_expected.to validate_presence_of :phone }
  it { is_expected.to validate_presence_of :address }
  it { is_expected.to validate_presence_of :postcode }
end
