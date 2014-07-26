require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe WhiteListsController do
  include AuthenticationHelper

  let(:white_list) { create(:white_list) }

  context 'not authenticated user' do
    context 'no login' do
      it 'should not allow user access' do
        get :index
        should_deny_user_access

        get :edit, id: white_list
        should_deny_user_access

        put :update, id: white_list, white_list: white_list.attributes
        should_deny_user_access

        delete :destroy, id: white_list
        should_deny_user_access

        get :new
        should_deny_user_access

        post :create, white_list: attributes_for(:white_list)
        should_deny_user_access
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

        get :edit, id: white_list
        should_deny_staff_access

        put :update, id: white_list, white_list: white_list.attributes
        should_deny_staff_access

        delete :destroy, id: white_list
        should_deny_staff_access

        get :new
        should_deny_staff_access

        post :create, white_list: attributes_for(:white_list)
        should_deny_staff_access
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

      it 'loads all of the posts into @white_lists' do
        white_list1, white_list2 = create(:white_list), create(:white_list)
        expect(assigns(:white_lists)).to match_array([white_list1, white_list2])
      end
    end

    describe 'GET #show' do
      it 'responds successfully' do
        get :show, id: white_list
        expect(response).to be_success
      end
      it 'renders the show template' do
        get :show, id: white_list
        expect(response).to render_template('show')
      end
    end

    describe 'GET #new' do
      before { get :new }
      it { is_expected.to render_template(:new) }

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'create new instance of white_list' do
        expect(assigns(:white_list)).to be_a_new(WhiteList)
      end
    end

    describe 'GET #edit' do
      before { get :edit, id: white_list }
      subject { response }

      it { is_expected.to render_template(:edit) }
      it { is_expected.to be_success }
    end

    describe 'PUT #update' do
      context 'when succeeds' do
        it 'redirects to white_list page' do
          put :update, id: white_list, white_list: white_list.attributes
          expect(response).to redirect_to(white_list_path(assigns(:white_list)))
        end

        it 'updates the white_list' do
          white_list
          put :update, id: white_list, white_list: {email: 'email@email.com'}
          expect(WhiteList.find(white_list).email).to eq('email@email.com')
        end
      end

      context 'when fails' do
        before { post :create, white_list: attributes_for(:white_list).merge(email: '') }
        it { is_expected.to render_template(:new) }
      end
    end

    describe 'POST #create' do
      context 'when succeeds' do
        it 'redirects to white_list page' do
          post :create, white_list: attributes_for(:white_list)
          expect(response).to redirect_to(white_list_path(assigns(:white_list)))
        end

        it 'creates and save waiting list' do
          expect { post :create, white_list: attributes_for(:white_list) }.to change { WhiteList.count }.by(1)
        end
      end

      context 'when fails' do
        before { post :create, white_list: attributes_for(:white_list).merge(email: '') }
        it { is_expected.to render_template(:new) }
      end
    end

    describe 'DELETE #delete white_list' do
      before { white_list }
      it { expect { delete :destroy, id: white_list }.to change { WhiteList.count }.by(-1) }
    end
  end
end
