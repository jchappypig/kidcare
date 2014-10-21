require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe GroupTimePlanningsController do
  include AuthenticationHelper

  let(:weekly_program) { create(:weekly_program) }
  let(:group_time_planning) { create(:group_time_planning, weekly_program: weekly_program) }

  context 'not authenticated user' do
    context 'no login' do
      it 'should not allow user access' do
        get :new, weekly_program_id: weekly_program
        should_deny_user_access

        post :create, group_time_planning: attributes_for(:group_time_planning), weekly_program_id: weekly_program
        should_deny_user_access

        delete :destroy, id: group_time_planning, weekly_program_id: weekly_program
        should_deny_user_access

        get :clone, weekly_program_id: weekly_program
        should_deny_user_access
      end
    end
    context 'non staff login' do
      before :each do
        parent = create(:user)
        sign_in :user, parent
      end

      it 'should not allow user access' do
        get :new, weekly_program_id: weekly_program
        should_deny_staff_access

        post :create, group_time_planning: attributes_for(:group_time_planning), weekly_program_id: weekly_program
        should_deny_staff_access

        delete :destroy, id: group_time_planning, weekly_program_id: weekly_program
        should_deny_staff_access

        get :clone, weekly_program_id: weekly_program
        should_deny_staff_access
      end
    end
  end

  context 'authenticated user' do
    before :each do
      admin = create(:admin)
      sign_in :user, admin
    end

    describe 'GET #new' do
      before { get :new, weekly_program_id: weekly_program }

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_success
        expect(response).to have_http_status(:ok)
      end

      it 'renders the new template' do
        expect(response).to render_template('new')
      end

      it 'creates new instance of group_time_planning' do
        expect(assigns(:group_time_planning)).to be_a_new(GroupTimePlanning)
      end

      it 'sets weekly program to group_time_planning' do
        expect(assigns(:group_time_planning).weekly_program_id).to be(weekly_program.id)
      end
    end

    describe 'Get #clone' do
      let(:group_time_planning1) { create(:group_time_planning, morning: 'morning1') }
      let(:group_time_planning2) { create(:group_time_planning, morning: 'morning2') }

      it 'clones the latest group_time_planning' do
        group_time_planning1
        group_time_planning2
        get :clone, weekly_program_id: weekly_program
        expect(assigns(:group_time_planning).morning).to eq(group_time_planning2.morning)
      end

      it 'should set weekly program id' do
        group_time_planning
        get :clone, weekly_program_id: weekly_program
        expect(assigns(:group_time_planning).weekly_program_id).to eq(weekly_program.id)
        expect(assigns(:group_time_planning).weekly_program_id).not_to eq(group_time_planning2.weekly_program_id)
      end

      it 'should just create a new group_time_planning with no details if no group_time_planning record' do
        get :clone, weekly_program_id: weekly_program
        expect(assigns(:group_time_planning).morning).to be_nil
      end
    end

    describe 'POST #create' do
      context 'when succeeds' do
        it 'redirects to group_time_planning selection page' do
          post :create, group_time_planning: attributes_for(:group_time_planning), weekly_program_id: weekly_program.id
          expect(response).to redirect_to(weekly_program_path(weekly_program))
        end

        it 'creates and save group time planning' do
          expect {
            post :create, group_time_planning: attributes_for(:group_time_planning), weekly_program_id: weekly_program.id
          }.to change { weekly_program.group_time_plannings.count }.by(1)
        end
      end

      context 'when fails' do
        before { post :create, group_time_planning: attributes_for(:group_time_planning).merge(day: ''), weekly_program_id: weekly_program }
        it { is_expected.to render_template(:new) }
      end
    end

    describe 'GET #edit' do
      before { get :edit, id: group_time_planning, weekly_program_id: weekly_program }
      subject { response }

      it { is_expected.to render_template(:edit) }
      it { is_expected.to be_success }
    end

    describe 'PUT #update' do

      context 'when succeeds' do
        it 'redirects to weekly program page' do
          put :update, weekly_program_id: weekly_program, group_time_planning: {morning: 'new morning activity'}, id: group_time_planning
          expect(response).to redirect_to(weekly_program_path(weekly_program))
        end

        it 'updates the weekly program' do
          group_time_planning
          put :update, weekly_program_id: weekly_program, group_time_planning: {morning: 'new morning activity'}, id: group_time_planning
          expect(GroupTimePlanning.find(group_time_planning).morning).to eq('new morning activity')
        end
      end

      it 'should not allow weekly program id to be mismatch' do
        another_weekly_program = create(:weekly_program)
        put :update, weekly_program_id: another_weekly_program, group_time_planning: {morning: 'new morning activity'}, id: group_time_planning
        expect(response).to render_template(:edit)
      end

      context 'when fails' do
        before { post :update, id: group_time_planning, group_time_planning: attributes_for(:group_time_planning).merge(day: ''), weekly_program_id: weekly_program }
        it { is_expected.to render_template(:edit) }
      end
    end

    describe 'DELETE #destory' do
      before { group_time_planning }
      it { expect { delete :destroy, weekly_program_id: weekly_program, id: group_time_planning }.to change { GroupTimePlanning.count }.by(-1) }
    end
  end
end
