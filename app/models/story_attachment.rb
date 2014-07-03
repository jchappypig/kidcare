class StoryAttachment < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :story
  validates :story, presence: true
  validates :photo, presence: true
end
