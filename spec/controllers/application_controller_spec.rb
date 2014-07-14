require 'rails_helper'
require File.dirname(__FILE__) + '/helpers/authentication_helper'

describe ApplicationController do
  include AuthenticationHelper

  context 'not authenticated user' do
    it 'should not allow user access' do
      get :our_stories
      should_deny_access
    end
  end

  context 'authenticated user' do
    before :each do
      user = create(:user)
      sign_in :user, user
    end

    describe 'GET #our_stories' do
      before { get :our_stories }
      it { is_expected.to render_template(:our_stories) }
    end
  end
end
