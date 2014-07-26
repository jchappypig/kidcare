class StoryAttachment < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :story
  validates :photo, presence: true
end
