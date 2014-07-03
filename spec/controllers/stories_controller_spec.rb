require 'rails_helper'

describe StoriesController do
  let(:story) { create(:story) }

  describe 'GET #index' do

    before { get :index }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'loads all of the posts into @stories' do
      story1, story2 = create(:story), create(:story)
      expect(assigns(:stories)).to match_array([story1, story2])
    end
  end

  describe 'GET #show' do
    before { get :show, id: story }
    subject { response }

    it { is_expected.to render_template(:show) }
    it { is_expected.to be_success }
  end

  describe 'GET #new' do
    before { get :new }
    it { is_expected.to render_template(:new) }

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'create new instance of story' do
      expect(assigns(:story)).to be_a_new(Story)
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: story }
    subject { response }

    it { is_expected.to render_template(:edit) }
    it { is_expected.to be_success }
  end

  describe 'POST #create' do
    context 'when succeeds' do
      it 'redirects to story page' do
        post :create, story: attributes_for(:story)
        expect(response).to redirect_to(story_path(assigns(:story)))
      end

      it 'create and save story' do
        expect { post :create, story: attributes_for(:story) }.to change { Story.count }.by(1)
      end
    end

    context 'when fails' do
      before { post :create, story: attributes_for(:story).merge(content: '') }
      it { is_expected.to render_template(:new) }
    end
  end
end
