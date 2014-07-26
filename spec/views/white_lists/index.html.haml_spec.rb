require 'rails_helper'

RSpec.describe "white_lists/index", :type => :view do
  before(:each) do
    assign(:white_lists, [
      WhiteList.create!(
        :email => "Email"
      ),
      WhiteList.create!(
        :email => "Email"
      )
    ])
  end

  it "renders a list of white_lists" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
