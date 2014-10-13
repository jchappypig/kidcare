class Activity < ActiveRecord::Base
  belongs_to :weekly_program

  validates :category, presence: true
  validates :day, presence: true
  validates :weekly_program_id, presence: true
end
