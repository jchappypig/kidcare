class Story < ActiveRecord::Base
  has_many :story_attachment
  accepts_nested_attributes_for :story_attachment
  validates :content, presence: true
end
