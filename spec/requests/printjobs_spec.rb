require 'rails_helper'

RSpec.describe "Printjobs", :type => :request do
  describe "GET /printjobs" do
    it "works! (now write some real specs)" do
      get printjobs_path
      expect(response).to have_http_status(200)
    end
  end
end
