class GroupTimePlanning < ActiveRecord::Base
  belongs_to :weekly_program
  validates :day, presence: true
end
