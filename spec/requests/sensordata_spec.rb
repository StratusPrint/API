require 'rails_helper'

RSpec.describe "Sensordata", :type => :request do
  describe "GET /sensordata" do
    it "works! (now write some real specs)" do
      get sensordata_path
      expect(response).to have_http_status(200)
    end
  end
end
