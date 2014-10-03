require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe WeeklyProgramsController do
  include AuthenticationHelper

  let(:weekly_program) { create(:weekly_program) }

  context 'not authenticated user' do
    context 'no login' do
      it 'should not allow user access' do
        get :index
        should_deny_user_access

        get :new
        should_deny_user_access

        post :create, our_weekly_program: attributes_for(:weekly_program)
        should_deny_user_access

        get :activity_selection
        should_deny_user_access

        # get :edit, id: weekly_program
        # should_deny_user_access
        #
        # put :update, id: weekly_program, weekly_program: weekly_program.attributes
        # should_deny_user_access
        #
        # delete :destroy, id: weekly_program
        # should_deny_user_access
      end
    end
    context 'non staff login' do
      before :each do
        parent = create(:user)
        sign_in :user, parent
      end

      it 'should not allow user access' do
        get :index
        should_deny_staff_access

        get :new
        should_deny_staff_access

        post :create, our_weekly_program: attributes_for(:weekly_program)
        should_deny_staff_access

        get :activity_selection
        should_deny_staff_access

        # get :edit, id: weekly_program
        # should_deny_staff_access
        #
        # put :update, id: weekly_program, weekly_program: weekly_program.attributes
        # should_deny_staff_access
        #
        # delete :destroy, id: weekly_program
        # should_deny_staff_access
      end
    end
  end
  context 'authenticated user' do
    before :each do
      admin = create(:admin)
      sign_in :user, admin
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

      it 'loads all of the weekly programs into @weekly_programs' do
        weekly_program1, weekly_program2 = create(:weekly_program), create(:weekly_program)
        expect(assigns(:weekly_programs)).to match_array([weekly_program1, weekly_program2])
      end
    end
    
    describe 'GET #new' do
      before { get :new }
      it { is_expected.to render_template(:new) }

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'create new instance of weekly_program' do
        expect(assigns(:weekly_program)).to be_a_new(WeeklyProgram)
      end
    end

    describe 'POST #create' do
      context 'when succeeds' do
        it 'redirects to activity selection page' do
          post :create, weekly_program: attributes_for(:weekly_program)
          expect(response).to redirect_to(activity_selection_path)
        end

        it 'creates and save weekly program' do
          expect { post :create, weekly_program: attributes_for(:weekly_program) }.to change { WeeklyProgram.count }.by(1)
        end
      end

      # context 'when fails' do
      #   before { post :create, weekly_program: attributes_for(:weekly_program).merge(email: '') }
      #   it { is_expected.to render_template(:new) }
      # end
    end

    describe 'Get #activity_selection' do
      before { get :activity_selection }
      it { is_expected.to render_template(:activity_selection) }

      it 'responds successfully' do
        expect(response).to be_success
      end
    end
  end
end