class StoryAttachmentsController < ApplicationController
  respond_to :json

  def destroy
    respond_with StoryAttachment.destroy(params[:id])
  end

  def show
    story_attachments = StoryAttachment.where(story_id: params[:story_id]).map do |attachment|
      {id: attachment.id, preview_url: attachment.photo_url(:preview),
       thumb_url: attachment.photo_url(:thumb), photo_url: attachment.photo_url}
    end
    respond_with story_attachments
  end
end
