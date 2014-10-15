require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe ApplicationController do
  include AuthenticationHelper

  context 'not authenticated user' do
    describe 'GET#our_stories' do
      it 'should not allow user access' do
        get :our_stories
        should_deny_user_access
      end
    end

    describe 'GET#weekly_program' do

      it 'should not allow user access' do
        get :weekly_program
        should_deny_user_access
      end
    end
  end

  context 'authenticated user' do
    before :each do
      user = create(:user)
      sign_in :user, user
    end

    describe 'Get #weekly_program' do
      it 'should assign latest weekly program' do
        weekly_program = create(:weekly_program, week_start: Date.parse('Monday'))
        last_weekly_program = create(:weekly_program, week_start: Date.parse('Monday') - 7)
        get :weekly_program
        expect(assigns(:latest_weekly_program)).to eq(weekly_program)
      end

      it 'renders template' do
        get :weekly_program
        expect(response).to render_template(:weekly_program)
      end

      it 'gets all story outcomes' do
        Outcome.create(item_no: '1', description: 'description1', category: '1');
        Outcome.create(item_no: '2', description: 'description2', category: '1');
        get :weekly_program
        expect(assigns(:outcomes).count).to eq 2
      end
    end

    describe 'GET #our_stories' do
      let(:today) { Date.today }
      let(:yesterday) { Date.yesterday }
      let(:the_day_before_yesterday) { 2.days.ago.to_date }
      let(:today_story) { create(:story, time_line: today) }
      let(:yesterday_story) { create(:story, time_line: yesterday) }
      let(:the_day_before_yesterday_story) { create(:story, time_line: the_day_before_yesterday) }

      it 'renders template' do
        today_story
        get :our_stories, date: today

        expect(response).to render_template(:our_stories)
      end

      it 'gets the stories for latest date if pass in an invalid format date' do
        today_story
        get :our_stories, date: 'invalid date'

        expect(assigns(:stories)).to include(today_story)
      end

      it 'gets stories for latest date if no date passed in' do
        today_story
        yesterday_story
        get :our_stories

        expect(assigns(:stories)).to include(today_story)
        expect(assigns(:stories)).not_to include(yesterday_story)
      end

      it 'gets stories by date' do
        today_story
        yesterday_story
        get :our_stories, date: yesterday

        expect(assigns(:stories)).not_to include(today_story)
        expect(assigns(:stories)).to include(yesterday_story)
      end

      it 'gets stories for latest if stories for specific date not found' do
        today_story
        yesterday_story

        get :our_stories, date: the_day_before_yesterday

        expect(assigns(:stories)).to include(today_story)
        expect(assigns(:stories)).not_to include(yesterday_story)
      end

      it 'returns the next available date and last available date for stories' do
        today_story
        yesterday_story
        the_day_before_yesterday_story

        get :our_stories, date: yesterday

        expect(assigns(:last_story_date)).to eq(the_day_before_yesterday)
        expect(assigns(:next_story_date)).to eq(today)
      end

      it 'returns no next available date and no last available date for stories if they are not available' do
        yesterday_story

        get :our_stories, date: yesterday

        expect(assigns(:last_story_date)).to be_nil
        expect(assigns(:next_story_date)).to be_nil
      end

      it 'should not throw exception if no story found' do
        get :our_stories

        expect(response).to render_template(:our_stories)
      end
    end
  end
end
