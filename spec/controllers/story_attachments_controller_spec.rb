require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe StoryAttachmentsController do
  let(:story_attachment) { create(:story_attachment) }
  describe 'DELETE #destory' do
    before { story_attachment }
    it { expect { delete :destroy, id: story_attachment, format: 'json' }.to change { StoryAttachment.count }.by(-1) }
  end

  describe 'GET #show' do
    before :each do
      story_attachment
      get :show, guid: story_attachment.guid, format: 'json'
    end

    it 'responds formatted attachments' do
      expect(response.body).to eq([{id: story_attachment.id,
                                    preview_url: story_attachment.photo_url(:preview),
                                    thumb_url: story_attachment.photo_url(:thumb),
                                    photo_url: story_attachment.photo_url}].to_json)
    end
  end
end
