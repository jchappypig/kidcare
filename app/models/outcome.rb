class Outcome < ActiveRecord::Base
  validates :item_no, presence: true
  validates :description, presence: true
  validates :category, presence: true
  has_many :story_outcomes
  has_many :stories, through: :story_outcomes

  def long_description
    return [item_no, description].join(' ')
  end
end
