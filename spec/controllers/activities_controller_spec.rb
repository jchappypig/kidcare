require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe ActivitiesController do
  include AuthenticationHelper

  let(:weekly_program) { create(:weekly_program) }
  let(:activity) { create(:activity, weekly_program: weekly_program) }

  context 'not authenticated user' do
    context 'no login' do
      it 'should not allow user access' do
        get :new, weekly_program_id: weekly_program
        should_deny_user_access

        get :activity_selection, weekly_program_id: weekly_program
        should_deny_user_access

        post :create, activity: attributes_for(:activity), weekly_program_id: weekly_program
        should_deny_user_access

        delete :destroy, id: activity, weekly_program_id: weekly_program
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

        get :activity_selection, weekly_program_id: weekly_program
        should_deny_staff_access

        post :create, activity: attributes_for(:activity), weekly_program_id: weekly_program
        should_deny_staff_access

        delete :destroy, id: activity, weekly_program_id: weekly_program
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

      it 'creates new instance of activity' do
        expect(assigns(:activity)).to be_a_new(Activity)
      end

      it 'sets weekly program to activity' do
        expect(assigns(:activity).weekly_program_id).to be(weekly_program.id)
      end

      context 'when passed in category' do
        it 'sets activity category' do
          get :new, weekly_program_id: weekly_program, category: 'indoor'
          expect(assigns(:activity).category).to eq('indoor')
        end
      end
    end

    describe 'Get #clone' do
      let(:indoor_activity1) { create(:activity, category: 'Indoor', cognitive: 'cognitive_indoor1') }
      let(:indoor_activity2) { create(:activity, category: 'Indoor', cognitive: 'cognitive_indoor2') }
      let(:outdoor_activity1) { create(:activity, category: 'Outdoor', cognitive: 'cognitive_outdoor1') }
      let(:outdoor_activity2) { create(:activity, category: 'Outdoor', cognitive: 'cognitive_outdoor2') }
      let(:any_activity1) { create(:activity, cognitive: 'cognitive1') }
      let(:any_activity2) { create(:activity, cognitive: 'cognitive2') }

      context 'when passed in category' do
        before :each do
          indoor_activity1
          indoor_activity2
          outdoor_activity1
          outdoor_activity2
        end

        it 'clones the latest activity of indoor category' do
          get :clone, weekly_program_id: weekly_program, category: 'Indoor'
          expect(assigns(:activity).cognitive).to eq(indoor_activity2.cognitive)
        end

        it 'clones the latest activity of outdoor category' do
          get :clone, weekly_program_id: weekly_program, category: 'Outdoor'
          expect(assigns(:activity).cognitive).to eq(outdoor_activity2.cognitive)
        end
      end

      context 'when no category passed in' do
        before :each do
          indoor_activity1
          indoor_activity2
          any_activity1
          any_activity2
        end

        it 'clones the latest activity of outdoor category' do
          get :clone, weekly_program_id: weekly_program
          expect(assigns(:activity).cognitive).to eq(any_activity2.cognitive)
        end
      end

      it 'should set weekly program id' do
        get :clone, weekly_program_id: weekly_program
        expect(assigns(:activity).weekly_program_id).to eq(weekly_program.id)
        expect(assigns(:activity).weekly_program_id).not_to eq(any_activity2.weekly_program_id)
      end

      it 'should just create a new activity with no details if no activity record' do
        get :clone, weekly_program_id: weekly_program
        expect(assigns(:activity).cognitive).to be_nil
      end
    end

    describe 'Get #activity_selection' do
      before { get :activity_selection, weekly_program_id: weekly_program }
      it { is_expected.to render_template(:activity_selection) }

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'gets weekly program id' do
        expect(assigns(:weekly_program_id)).to eq(weekly_program.id.to_s)
      end
    end

    describe 'POST #create' do
      context 'when succeeds' do
        it 'redirects to activity selection page' do
          post :create, activity: attributes_for(:activity), weekly_program_id: weekly_program.id
          expect(response).to redirect_to(weekly_program_path(weekly_program))
        end

        it 'creates and save activity' do
          expect {
            post :create, activity: attributes_for(:activity), weekly_program_id: weekly_program.id
          }.to change { weekly_program.activities.count }.by(1)
        end
      end

      context 'when fails' do
        before { post :create, activity: attributes_for(:activity).merge(day: ''), weekly_program_id: weekly_program }
        it { is_expected.to render_template(:new) }
      end
    end

    describe 'GET #edit' do
      before { get :edit, id: activity, weekly_program_id: weekly_program }
      subject { response }

      it { is_expected.to render_template(:edit) }
      it { is_expected.to be_success }
    end

    describe 'PUT #update' do

      context 'when succeeds' do
        it 'redirects to weekly program page' do
          put :update, weekly_program_id: weekly_program, activity: {category: 'new category'}, id: activity
          expect(response).to redirect_to(weekly_program_path(weekly_program))
        end

        it 'updates the weekly program' do
          activity
          put :update, weekly_program_id: weekly_program, activity: {category: 'new category'}, id: activity
          expect(Activity.find(activity).category).to eq('new category')
        end
      end

      it 'should not allow weekly program id to be mismatch' do
        another_weekly_program = create(:weekly_program)
        put :update, weekly_program_id: another_weekly_program, activity: {category: 'new category'}, id: activity
        expect(response).to render_template(:edit)
      end

      context 'when fails' do
        before { post :update, id: activity, activity: attributes_for(:activity).merge(day: ''), weekly_program_id: weekly_program }
        it { is_expected.to render_template(:edit) }
      end
    end

    describe 'DELETE #destory' do
      before { activity }
      it { expect { delete :destroy, weekly_program_id: weekly_program, id: activity }.to change { Activity.count }.by(-1) }
    end
  end
end
