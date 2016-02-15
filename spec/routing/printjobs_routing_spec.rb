require "rails_helper"

RSpec.describe PrintjobsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/printjobs").to route_to("printjobs#index")
    end

    it "routes to #new" do
      expect(:get => "/printjobs/new").to route_to("printjobs#new")
    end

    it "routes to #show" do
      expect(:get => "/printjobs/1").to route_to("printjobs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/printjobs/1/edit").to route_to("printjobs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/printjobs").to route_to("printjobs#create")
    end

    it "routes to #update" do
      expect(:put => "/printjobs/1").to route_to("printjobs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/printjobs/1").to route_to("printjobs#destroy", :id => "1")
    end

  end
end
