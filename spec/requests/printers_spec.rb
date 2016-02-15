require 'rails_helper'

RSpec.describe "Printers", :type => :request do
  describe "GET /printers" do
    it "works! (now write some real specs)" do
      get printers_path
      expect(response).to have_http_status(200)
    end
  end
end
