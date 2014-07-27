require 'rails_helper'

describe RegistrationsController do
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  let(:user) {create(:user)}

  it 'should allow user to register if in the white list' do
    user_attributes = attributes_for(:user)
    create(:white_list, email: user_attributes[:email])
    post :create, user: user_attributes
    expect(flash[:notice]).to eq 'Welcome! You have signed up successfully.'
  end

  it 'should not allow user to register if not in the white list' do
    post :create, user: attributes_for(:user)
    expect(flash[:alert]).to eq 'Hey, you are not allow to register. Please ask Little Star Early Learning Centre for permission.'
    expect(response).to redirect_to root_path
  end
end
