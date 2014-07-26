namespace :db do
  desc 'set guid for existing story attachments'
  task :set_attachment_guid => :environment do
    Story.all.each do |story|
      if(story.guid.nil?)
        story.guid = SecureRandom.uuid
        story.save!
      end
      story.story_attachment.where(guid: nil).update_all(guid: story.guid)
    end
  end
end
