class Story < ActiveRecord::Base
  has_many :story_attachments
  accepts_nested_attributes_for :story_attachments
end
