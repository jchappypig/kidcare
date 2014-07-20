class StoryAttachmentsController < ApplicationController
  respond_to :json

  def destroy
    respond_with StoryAttachment.destroy(params[:id])
  end

  def show
    story_attachments = StoryAttachment.where(story_id: params[:story_id]).map do |attachment|
      {id: attachment.id, photo_url: attachment.photo_url}
    end
    respond_with story_attachments
  end
end
