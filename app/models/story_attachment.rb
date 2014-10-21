class StoryAttachment < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :story
  validates :photo, presence: true

  after_create :recruit_orphan_attachments

  private

  def recruit_orphan_attachments
    if story_id.nil?
      story = Story.find_by(guid: guid)
      if story.present?
        self.story_id = story.id
      end
    end
  end
end
