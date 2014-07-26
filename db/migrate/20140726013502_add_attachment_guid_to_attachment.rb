class AddAttachmentGuidToAttachment < ActiveRecord::Migration
  def change
    add_column :story_attachments, :guid, :uuid
    add_column :stories, :guid, :uuid
  end
end
