class Story < ActiveRecord::Base
  has_many :story_attachment, dependent: :destroy
  accepts_nested_attributes_for :story_attachment
  validates :content, presence: true
  has_many :story_outcomes
  has_many :outcomes, through: :story_outcomes
end
