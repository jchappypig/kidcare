require 'rails_helper'

RSpec.describe "white_lists/edit", :type => :view do
  before(:each) do
    @white_list = assign(:white_list, WhiteList.create!(
      :email => "MyString"
    ))
  end

  it "renders the edit white_list form" do
    render

    assert_select "form[action=?][method=?]", white_list_path(@white_list), "post" do

      assert_select "input#white_list_email[name=?]", "white_list[email]"
    end
  end
end
