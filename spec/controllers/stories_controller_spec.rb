require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe StoriesController do
  include AuthenticationHelper

  let(:story) { create(:story) }

  let(:photoOne) { attributes_for(:story_attachment)[:photo] }
  let(:photoTwo) { attributes_for(:story_attachment, another_photo: true)[:photo] }

  context 'not authenticated user' do
    it 'should not allow user access' do
      get :index
      should_deny_user_access

      get :new
      should_deny_user_access

      post :create, story: attributes_for(:story)
      should_deny_user_access

      get :edit, id: story
      should_deny_user_access

      put :update, id: story, story: story.attributes
      should_deny_user_access

      delete :destroy, id: story
      should_deny_user_access
    end
  end

  context 'authenticated user' do
    before :each do
      user = create(:user)
      sign_in :user, user
    end

    describe 'GET #index' do
      before { get :index }

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_success
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        expect(response).to render_template('index')
      end

      it 'loads all of the posts into @stories' do
        story1, story2 = create(:story), create(:story)
        expect(assigns(:stories)).to match_array([story1, story2])
      end
    end

    describe 'GET #show' do
      it 'responds successfully' do
        get :show, id: story
        expect(response).to be_success
      end
      it 'renders the show template' do
        get :show, id: story
        expect(response).to render_template('show')
      end

      context 'when there are story attachments' do
        it 'displayed all attachments' do
          story = create(:story_with_attachments, attachments_count: 3)
          get :show, id: story

          expect(assigns(:story_attachments).count).to eq(3)
        end
      end
    end

    describe 'GET #new' do
      before { get :new }
      it { is_expected.to render_template(:new) }

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'create new instance of story' do
        expect(assigns(:story)).to be_a_new(Story)
      end
    end

    describe 'GET #edit' do
      before { get :edit, id: story }
      subject { response }

      it { is_expected.to render_template(:edit) }
      it { is_expected.to be_success }

      it('assigns the story attachments as json') do
        story = create(:story_with_attachments)

        get :edit, id: story

        story_attachment = story.story_attachment.first
        expect(assigns(:story_attachments_as_json)).to eq([{id: story_attachment.id, photo_url: story_attachment.photo_url}].to_json)
      end
    end

    describe 'POST #create' do
      context 'when succeeds' do
        it 'redirects to story page' do
          post :create, story: attributes_for(:story)
          expect(response).to redirect_to(story_path(assigns(:story)))
        end

        it 'creates and save story' do
          expect { post :create, story: attributes_for(:story) }.to change { Story.count }.by(1)
        end

        context 'when there are story attachments' do
          it 'creates and save story attachments' do
            post :create,
                 {story: attributes_for(:story)}.merge(story_attachments: {photo: [photoOne, photoTwo]})
            expect(Story.first.story_attachment.count).to eq 2
          end
        end
      end

      context 'when fails' do
        before { post :create, story: attributes_for(:story).merge(content: '') }
        it { is_expected.to render_template(:new) }
      end
    end

    describe 'PUT #update' do
      context 'when succeeds' do
        it 'redirects to story page' do
          put :update, id: story, story: story.attributes
          expect(response).to redirect_to(story_path(assigns(:story)))
        end

        it 'updates the story' do
          story
          put :update, id: story, story: {content: 'new content'}
          expect(Story.find(story).content).to eq('new content')
        end

        context 'when story attachments changed' do
          it 'updates story attachments' do
            story = create(:story_with_attachments, attachments_count: 1)
            expect(story.story_attachment.first.photo_url).to include(photoOne.original_filename)

            put :update, id: story, story_attachments: {photo: [photoTwo]}, story: attributes_for(:story)

            updated_story = Story.find(story)
            expect(updated_story.story_attachment.count).to eq(2)
            expect(updated_story.story_attachment.map { |attachment| Pathname.new(attachment.photo_url).basename.to_s }).
                to match_array([photoOne.original_filename, photoTwo.original_filename])
          end
        end
      end

      context 'when fails' do
        before { post :create, story: attributes_for(:story).merge(content: '') }
        it { is_expected.to render_template(:new) }
      end
    end

    describe 'DELETE #destory' do
      before { story }
      it { expect { delete :destroy, id: story }.to change { Story.count }.by(-1) }
    end
  end


end
