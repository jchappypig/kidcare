class StoryAttachmentsController < ApplicationController
  respond_to :json

  def destroy
    respond_with StoryAttachment.destroy(params[:id])
  end
end
