require "rails_helper"

RSpec.describe SensordataController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sensordata").to route_to("sensordata#index")
    end

    it "routes to #new" do
      expect(:get => "/sensordata/new").to route_to("sensordata#new")
    end

    it "routes to #show" do
      expect(:get => "/sensordata/1").to route_to("sensordata#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sensordata/1/edit").to route_to("sensordata#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sensordata").to route_to("sensordata#create")
    end

    it "routes to #update" do
      expect(:put => "/sensordata/1").to route_to("sensordata#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sensordata/1").to route_to("sensordata#destroy", :id => "1")
    end

  end
end
