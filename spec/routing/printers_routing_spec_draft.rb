require "rails_helper"

RSpec.describe Api::V1::PrintersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/printers").to route_to("printers#index")
    end

    it "routes to #new" do
      expect(:get => "/printers/new").to route_to("printers#new")
    end

    it "routes to #show" do
      expect(:get => "/printers/1").to route_to("printers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/printers/1/edit").to route_to("printers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/printers").to route_to("printers#create")
    end

    it "routes to #update" do
      expect(:put => "/printers/1").to route_to("printers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/printers/1").to route_to("printers#destroy", :id => "1")
    end

  end
end
