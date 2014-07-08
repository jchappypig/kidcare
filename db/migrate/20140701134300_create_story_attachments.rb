class CreateStoryAttachments < ActiveRecord::Migration
  def change
    create_table :story_attachments do |t|
      t.belongs_to :story
      t.string :photo
    end
  end
end
