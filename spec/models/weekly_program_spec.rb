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
  it { is_expected.to have_many(:activities).dependent(:destroy) }

  describe 'week_range' do
    it 'should show week start day and end day' do
      weekly_program = create(:weekly_program, week_start: Date.new(2014, 10, 20))
      expect(weekly_program.week_range).to eq('20th Oct, 2014 to 24th Oct, 2014')
    end
  end

  describe 'indoor and out door activities' do
    let(:weekly_program) { create(:weekly_program) }
    let(:indoor_activity) { create(:activity, category: 'Indoor', weekly_program: weekly_program) }
    let(:outdoor_activity) { create(:activity, category: 'Outdoor', weekly_program: weekly_program) }

    describe 'indoor_activities' do
      it 'should return indoor activities' do
        expect(weekly_program.indoor_activities).to include(indoor_activity)
        expect(weekly_program.indoor_activities).not_to include(outdoor_activity)
      end
    end

    describe 'outdoor_activities' do
      it 'should return outdoor activities' do
        expect(weekly_program.outdoor_activities).not_to include(indoor_activity)
        expect(weekly_program.outdoor_activities).to include(outdoor_activity)
      end
    end
  end
end
