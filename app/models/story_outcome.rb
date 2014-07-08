class StoryOutcome < ActiveRecord::Base
  belongs_to :story
  belongs_to :outcome
end
