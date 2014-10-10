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
end
