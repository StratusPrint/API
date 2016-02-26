require 'rails_helper'

RSpec.describe "DataPoints", :type => :request do
  describe "GET /data_points" do
    it "works! (now write some real specs)" do
      get data_points_path
      expect(response).to have_http_status(200)
    end
  end
end
