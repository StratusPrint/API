require 'rails_helper'

RSpec.describe "Sensors", :type => :request do
  describe "GET /sensors" do
    it "works! (now write some real specs)" do
      get sensors_path
      expect(response).to have_http_status(200)
    end
  end
end
