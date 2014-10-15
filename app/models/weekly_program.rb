require 'date'

class WeeklyProgram < ActiveRecord::Base
  validates :week_start, presence: true
  validates :program_staff, presence: true
  validates :theme, presence: true
  validates :goals, presence: true
  validates :letter, presence: true
  validates :number, presence: true
  validates :colour, presence: true
  validates :shape, presence: true
  has_many :activities, dependent: :destroy

  def week_range
    week_start_desc = to_word(week_start)
    week_end_desc = to_word(week_start + 4)
    return week_start_desc + ' to ' + week_end_desc
  end

  def to_word(date)
    date.strftime("#{date.day.ordinalize} %b, %Y")
  end

  def indoor_activities
    find_by_category('Indoor')
  end

  def outdoor_activities
    find_by_category('Outdoor')
  end

  def self.latest
    WeeklyProgram.order('week_start').last
  end

  private

  def priority
    %w(Monday Tuesday Wednesday Thursday Friday)
  end

  def find_by_category(category)
    activities.where(category: category).sort_by { |activity| priority.index(activity.day) || priority.size }
  end
end
