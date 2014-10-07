require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe ActivitiesController do
  include AuthenticationHelper

  let(:weekly_program) { create(:weekly_program) }

  context 'not authenticated user' do
    context 'no login' do
      it 'should not allow user access' do
        get :new, weekly_program_id: weekly_program
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
    end
  end


end
