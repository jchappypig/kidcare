require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe ApplicationController do
  include AuthenticationHelper

  context 'not authenticated user' do
    it 'should not allow user access' do
      get :our_stories
      should_deny_user_access
    end
  end

  context 'authenticated user' do
    before :each do
      user = create(:user)
      sign_in :user, user
    end

    describe 'GET #our_stories' do
      before(:each) do
        @today = Date.today
        @yesterday = Date.yesterday

        @today_story = create(:story, time_line: @today)
        @yesterday_story = create(:story, time_line: @yesterday)
      end

      it 'renders template' do
        get :our_stories

        expect(response).to render_template(:our_stories)
      end

      it 'gets stories for today if no date passed in' do
        get :our_stories

        expect(assigns(:stories)).to include(@today_story)
        expect(assigns(:stories)).not_to include(@yesterday_story)
      end

      it 'gets stories by date' do
        get :our_stories, date: @yesterday

        expect(assigns(:stories)).not_to include(@today_story)
        expect(assigns(:stories)).to include(@yesterday_story)
      end

      it 'gets stories for today if stories for specific date not found' do
        tomorrow = Date.tomorrow

        get :our_stories, date: tomorrow

        expect(assigns(:stories)).to include(@today_story)
        expect(assigns(:stories)).not_to include(@yesterday_story)
      end
    end
  end
end
