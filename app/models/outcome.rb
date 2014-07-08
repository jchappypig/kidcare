class Outcome < ActiveRecord::Base
  validates :item_no, presence: true
  validates :description, presence: true
  validates :category, presence: true
  has_many :story_outcomes
  # has_many :stories, through: :story_outcomes
end
