require 'rails_helper'

describe WeeklyProgram do
  it { is_expected.to validate_presence_of :week_start }
  it { is_expected.to validate_presence_of :program_staff }
  it { is_expected.to validate_presence_of :theme }
  it { is_expected.to validate_presence_of :goals }
  it { is_expected.to validate_presence_of :letter }
  it { is_expected.to validate_presence_of :number }
  it { is_expected.to validate_presence_of :colour }
  it { is_expected.to validate_presence_of :shape }
  it { is_expected.to have_many :activities}
end
