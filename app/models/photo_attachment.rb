class PhotoAttachment < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :story
end
