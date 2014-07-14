require 'rails_helper'

describe Outcome do
  it { is_expected.to validate_presence_of :item_no }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to have_many :story_outcomes}
  it { is_expected.to have_many(:stories).through(:story_outcomes)}

  describe 'long description' do
    it 'returns item no and description' do
      item_no = '1.1';
      description = Faker::Lorem.sentence
      outcome = Outcome.new(item_no: item_no, description: description)

      expect(outcome.long_description).to include(item_no)
      expect(outcome.long_description).to include(description)
    end
  end
end
