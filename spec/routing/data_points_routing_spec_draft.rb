require "rails_helper"

RSpec.describe Api::V1::DataPointsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/data_points").to route_to("data_points#index")
    end

    it "routes to #new" do
      expect(:get => "/data_points/new").to route_to("data_points#new")
    end

    it "routes to #show" do
      expect(:get => "/data_points/1").to route_to("data_points#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/data_points/1/edit").to route_to("data_points#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/data_points").to route_to("data_points#create")
    end

    it "routes to #update" do
      expect(:put => "/data_points/1").to route_to("data_points#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/data_points/1").to route_to("data_points#destroy", :id => "1")
    end

  end
end
