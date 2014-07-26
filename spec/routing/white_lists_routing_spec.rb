require "rails_helper"

RSpec.describe WhiteListsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/white_lists").to route_to("white_lists#index")
    end

    it "routes to #new" do
      expect(:get => "/white_lists/new").to route_to("white_lists#new")
    end

    it "routes to #show" do
      expect(:get => "/white_lists/1").to route_to("white_lists#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/white_lists/1/edit").to route_to("white_lists#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/white_lists").to route_to("white_lists#create")
    end

    it "routes to #update" do
      expect(:put => "/white_lists/1").to route_to("white_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/white_lists/1").to route_to("white_lists#destroy", :id => "1")
    end

  end
end
