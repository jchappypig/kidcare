require 'rails_helper'

RSpec.describe "white_lists/new", :type => :view do
  before(:each) do
    assign(:white_list, WhiteList.new(
      :email => "MyString"
    ))
  end

  it "renders new white_list form" do
    render

    assert_select "form[action=?][method=?]", white_lists_path, "post" do

      assert_select "input#white_list_email[name=?]", "white_list[email]"
    end
  end
end
