require 'rails_helper'

describe StoriesController do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'loads all of the posts into @stories' do
      story1, story2 = Story.create!, Story.create!
      get :index

      expect(assigns(:stories)).to match_array([story1, story2])
    end
  end
end
