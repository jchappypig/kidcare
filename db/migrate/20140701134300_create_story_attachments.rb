class CreateStoryAttachments < ActiveRecord::Migration
  def change
    create_table :story_attachments do |t|
      t.integer :story_id
      t.string :photo
    end
  end
end
