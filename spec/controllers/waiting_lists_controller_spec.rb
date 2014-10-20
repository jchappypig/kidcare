require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe WaitingListsController do
  include AuthenticationHelper

  let(:waiting_list) { create(:waiting_list) }

  context 'not authenticated user' do
    context 'no login' do
      it 'should not allow user access' do
        get :index
        should_deny_user_access

        get :edit, id: waiting_list
        should_deny_user_access

        put :update, id: waiting_list, waiting_list: waiting_list.attributes
        should_deny_user_access

        delete :destroy, id: waiting_list
        should_deny_user_access
      end

      describe 'POST #create' do
        context 'when succeeds' do
          it 'redirects to home page' do
            post :create, waiting_list: attributes_for(:waiting_list)
            expect(response).to redirect_to(root_path)
          end

          it 'creates and save waiting list' do
            expect { post :create, waiting_list: attributes_for(:waiting_list) }.to change { WaitingList.count }.by(1)
          end

          it 'set date contacted with date created by default' do
            post :create, waiting_list: attributes_for(:waiting_list)
            expect(assigns(:waiting_list).date_contacted).not_to be_nil
          end
        end

        context 'when fails' do
          before { post :create, waiting_list: attributes_for(:waiting_list).merge(child_full_name: '') }
          it { is_expected.to render_template(:new) }
        end
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

        get :edit, id: waiting_list
        should_deny_staff_access

        put :update, id: waiting_list, waiting_list: waiting_list.attributes
        should_deny_staff_access

        delete :destroy, id: waiting_list
        should_deny_staff_access
      end
    end
  end

  context 'authenticated user' do
    before :each do
      admin = create(:admin)
      sign_in :user, admin
    end

    describe 'POST #create' do
      context 'when succeeds' do
        it 'redirects to home page' do
          post :create, waiting_list: attributes_for(:waiting_list)
          expect(response).to redirect_to(waiting_list_path(assigns(:waiting_list)))
        end
      end
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

      it 'loads all of the posts into @waiting_lists' do
        waiting_list1, waiting_list2 = create(:waiting_list), create(:waiting_list)
        expect(assigns(:waiting_lists)).to match_array([waiting_list1, waiting_list2])
      end
    end

    describe 'GET #show' do
      it 'responds successfully' do
        get :show, id: waiting_list
        expect(response).to be_success
      end
      it 'renders the show template' do
        get :show, id: waiting_list
        expect(response).to render_template('show')
      end
    end

    describe 'GET #new' do
      before { get :new }
      it { is_expected.to render_template(:new) }

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'create new instance of waiting_list' do
        expect(assigns(:waiting_list)).to be_a_new(WaitingList)
      end
    end

    describe 'GET #edit' do
      before { get :edit, id: waiting_list }
      subject { response }

      it { is_expected.to render_template(:edit) }
      it { is_expected.to be_success }
    end

    describe 'PUT #update' do
      context 'when succeeds' do
        it 'redirects to waiting_list page' do
          put :update, id: waiting_list, waiting_list: waiting_list.attributes
          expect(response).to redirect_to(waiting_list_path(assigns(:waiting_list)))
        end

        it 'updates the waiting_list' do
          waiting_list
          put :update, id: waiting_list, waiting_list: {child_full_name: 'new name'}
          expect(WaitingList.find(waiting_list).child_full_name).to eq('new name')
        end
      end

      context 'when fails' do
        before { post :create, waiting_list: attributes_for(:waiting_list).merge(child_full_name: '') }
        it { is_expected.to render_template(:new) }
      end
    end

    describe 'DELETE #waiting_list' do
      before { waiting_list }
      it { expect { delete :destroy, id: waiting_list }.to change { WaitingList.count }.by(-1) }
    end
  end
end
