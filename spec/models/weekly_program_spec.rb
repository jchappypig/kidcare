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
  it { is_expected.to have_many(:group_time_plannings).dependent(:destroy) }

  describe 'week_range' do
    it 'should show week start day and end day' do
      weekly_program = create(:weekly_program, week_start: Date.new(2014, 10, 20))
      expect(weekly_program.week_range).to eq('20th Oct, 2014 to 24th Oct, 2014')
    end
  end

  describe 'indoor and out door activities' do
    let(:weekly_program) { create(:weekly_program) }
    let(:indoor_activity) { create(:activity, category: 'Indoor', weekly_program: weekly_program, day: 'Monday') }
    let(:outdoor_activity) { create(:activity, category: 'Outdoor', weekly_program: weekly_program, day: 'Monday') }

    describe 'indoor_activities' do
      it 'should return indoor activities' do
        indoor_activity
        outdoor_activity
        expect(weekly_program.indoor_activities).to include(indoor_activity)
        expect(weekly_program.indoor_activities).not_to include(outdoor_activity)
      end

      it 'should sort by day' do
        tuesday_activity = create(:activity, category: 'Indoor', weekly_program: weekly_program, day: 'Tuesday')
        monday_activity = create(:activity, category: 'Indoor', weekly_program: weekly_program, day: 'Monday')
        wednesday_activity = create(:activity, category: 'Indoor', weekly_program: weekly_program, day: 'Wednesday')
        expect(weekly_program.indoor_activities.first).to eq monday_activity
        expect(weekly_program.indoor_activities.second).to eq tuesday_activity
        expect(weekly_program.indoor_activities.last).to eq wednesday_activity
      end
    end

    describe 'outdoor_activities' do
      it 'should return outdoor activities' do
        indoor_activity
        outdoor_activity
        expect(weekly_program.outdoor_activities).not_to include(indoor_activity)
        expect(weekly_program.outdoor_activities).to include(outdoor_activity)
      end
    end
  end

  describe 'group time plannings' do
    it 'should sort by day' do
      weekly_program = create(:weekly_program)
      tuesday_group_time = create(:group_time_planning, weekly_program: weekly_program, day: 'Tuesday')
      monday_group_time = create(:group_time_planning, weekly_program: weekly_program, day: 'Monday')
      alternative_group_time = create(:group_time_planning, weekly_program: weekly_program, day: 'Alternative')

      expect(weekly_program.group_time_plannings_sorted.first).to eq monday_group_time
      expect(weekly_program.group_time_plannings_sorted.second).to eq tuesday_group_time
      expect(weekly_program.group_time_plannings_sorted.last).to eq alternative_group_time
    end
  end

  describe 'latest' do
    let(:weekly_program) { create(:weekly_program, week_start: Date.parse('Monday')) }
    let(:last_weekly_program) { create(:weekly_program, week_start: Date.parse('Monday') - 7) }

    it 'should return the latest weekly program' do
      weekly_program
      last_weekly_program

      expect(WeeklyProgram.latest).to eq(weekly_program)
    end
  end
end
