require "rails_helper"

describe "Printer Management", :type => :request do
  let!(:hubs) { create_list(:hub, 3) }
  let(:printer) { hubs.first.printers.first }
  let(:new_printer) { build :printer }
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:admin_auth_headers) { admin.create_new_auth_token }
  let(:user_auth_headers) { user.create_new_auth_token }
  let(:hub_auth_headers) { hubs.first.create_new_auth_token }

  context "GET /hubs/:id/printers" do
    it "should not return a hub's printers if not authenticated" do
      get v1_hub_printers_path(hubs.first.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not return a hub's printers if not authenticated as that hub" do
      get v1_hub_printers_path(hubs.second.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a hub's printers if authenticated as that hub" do
      get v1_hub_printers_path(hubs.first.id), headers: hub_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(hubs.first.printers.length)
    end

    it "should return a hub's printers if authenticated as user" do
      get v1_hub_printers_path(hubs.first.id), headers: user_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(hubs.first.printers.length)
    end

    it "should return a hub's printers if authenticated as admin" do
      get v1_hub_printers_path(hubs.first.id), headers: admin_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(hubs.first.printers.length)
    end
  end

  context "POST /hubs/:id/printers" do
    it "should not create a new printer if not authenticated" do
      post v1_hub_printers_path(hubs.first.id), params: { printer: new_printer.attributes }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should create a new printer if authenticated as parent hub" do
      post v1_hub_printers_path(hubs.first.id), params: { printer: new_printer.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:created)
      expect(response).to match_response_schema("printer")
    end

    it "should not create a new printer if not authenticated as parent hub" do
      post v1_hub_printers_path(hubs.second.id), params: { printer: new_printer.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not create a new printer if authenticated as user" do
      post v1_hub_printers_path(hubs.first.id), params: { printer: new_printer.attributes }, headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should create a new printer if authenticated as admin" do
      post v1_hub_printers_path(hubs.first.id), params: { printer: new_printer.attributes }, headers: admin_auth_headers
      expect(response).to have_http_status(:created)
      expect(response).to match_response_schema("printer")
    end
  end

  context "DELETE /printers/:id" do
    it "should not delete a printer if not authenticated" do
      delete v1_printer_path(printer.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not delete a printer if authenticated as hub" do
      delete v1_printer_path(printer.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not delete a printer if authenticated as user" do
      delete v1_printer_path(printer.id), headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should delete a printer if authenticated as admin" do
      delete v1_printer_path(printer.id), headers: admin_auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end

  context "GET /printers/:id" do
    it "should not return a printer if not authenticated" do
      get v1_printer_path(printer.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should return a printer if authenticated as parent hub" do
      get v1_printer_path(printer.id), headers: hub_auth_headers
      expect(response).to have_http_status(:success)
    end

    it "should not return a printer if not authenticated as parent hub" do
      get v1_printer_path(hubs.second.printers.first.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a printer if authenticated as user" do
      get v1_printer_path(printer.id), headers: user_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("printer")
    end

    it "should return a printer if authenticated as admin" do
      get v1_printer_path(printer.id), headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("printer")
    end
  end

  context "PATCH /printers/:id" do
    it "should not update a printer if not authenticated" do
      patch v1_printer_path(printer.id), params: { printer: new_printer.attributes }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should update a printer if authenticated as parent hub" do
      patch v1_printer_path(printer.id), params: { printer: new_printer.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:success)
    end

    it "should not update a printer if not authenticated as parent hub" do
      patch v1_printer_path(hubs.second.printers.first.id), params: { printer: new_printer.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not update a printer if authenticated as user" do
      patch v1_printer_path(printer.id), params: { printer: new_printer.attributes }, headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should update a printer if authenticated as admin" do
      patch v1_printer_path(printer.id), params: { printer: new_printer.attributes }, headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("printer")
    end
  end
end
