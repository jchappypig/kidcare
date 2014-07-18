class Story < ActiveRecord::Base
  has_many :story_attachment, dependent: :destroy
  accepts_nested_attributes_for :story_attachment
  validates :content, presence: true
  has_many :story_outcomes
  has_many :outcomes, through: :story_outcomes

  def get_story_attachments_as_json
    story_attachments = self.story_attachment.map do |attachment|
      {id: attachment.id, photo_url: attachment.photo_url}
    end
    return story_attachments.to_json
  end
end
