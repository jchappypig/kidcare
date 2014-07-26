require 'rails_helper'

RSpec.describe "WhiteLists", :type => :request do
  describe "GET /white_lists" do
    it "works! (now write some real specs)" do
      get white_lists_path
      expect(response.status).to be(200)
    end
  end
end
