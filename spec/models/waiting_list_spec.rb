require 'rails_helper'

describe WaitingList do
  it { is_expected.to validate_presence_of :child_full_name }
  it { is_expected.to validate_presence_of :child_dob }
  it { is_expected.to validate_presence_of :parent_full_name }
  it { is_expected.to validate_presence_of :home_phone }
  it { is_expected.to validate_presence_of :mobile_phone }
  it { is_expected.to validate_presence_of :address }
end
