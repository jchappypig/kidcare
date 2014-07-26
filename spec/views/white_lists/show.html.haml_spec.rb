require 'rails_helper'

RSpec.describe "white_lists/show", :type => :view do
  before(:each) do
    @white_list = assign(:white_list, WhiteList.create!(
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
  end
end
