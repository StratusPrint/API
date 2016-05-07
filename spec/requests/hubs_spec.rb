require "rails_helper"

describe "Hub Management", :type => :request do
  let!(:hubs) { create_list(:hub, 3) }
  let(:new_hub) { build :hub }
  let(:new_sensor) { build :sensor }
  let(:new_printer) { build :printer }
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:admin_auth_headers) { admin.create_new_auth_token }
  let(:user_auth_headers) { user.create_new_auth_token }
  let(:hub_auth_headers) { hubs.first.create_new_auth_token }

  context "GET /hubs" do
    it "should not return all hubs if not authenticated" do
      get v1_hubs_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not return all hubs if authenticated as hub" do
      get v1_hubs_path, headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return all hubs if authenticated as admin" do
      get v1_hubs_path, headers: admin_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(hubs.length)
    end

    it "should return all hubs if authenticated as user" do
      get v1_hubs_path, headers: user_auth_headers
      expect(response).to have_http_status(:success)
    end
  end

  context "POST /hubs" do
    it "should not create a new hub if not authenticated" do
      post v1_hubs_path, params: { hub: new_hub.attributes }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not create a new hub if authenticated as hub" do
      post v1_hubs_path(new_hub), params: { hub: new_hub.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not create a new hub if authenticated as user" do
      post v1_hubs_path(new_hub), params: { hub: new_hub.attributes }, headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should create a new hub if authenticated as admin" do
      post v1_hubs_path, params: { hub: new_hub.attributes }, headers: admin_auth_headers
      expect(response).to have_http_status(:created)
      expect(response).to match_response_schema("hub")
    end
  end

  context "GET /hubs/:id" do
    it "should not return a hub if not authenticated" do
      get v1_hub_path(hubs.first.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should return a hub if authenticated as that hub" do
      get v1_hub_path(hubs.first.id), headers: hub_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("hub")
    end

    it "should not return a hub if not authenticated as that hub" do
      get v1_hub_path(hubs.second.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a hub if authenticated as user" do
      get v1_hub_path(hubs.first.id), headers: user_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("hub")
    end

    it "should return a hub if authenticated as admin" do
      get v1_hub_path(hubs.first.id), headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("hub")
    end
  end

  context "PATCH /hubs/:id" do
    it "should not update a hub if not authenticated" do
      patch v1_hub_path(hubs.first.id), params: { hub: new_hub.attributes }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should update a hub if authenticated as hub" do
      patch v1_hub_path(hubs.first.id), params: { hub: new_hub.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:success)
    end

    it "should not update a hub if authenticated as user" do
      patch v1_hub_path(hubs.first.id), params: { hub: new_hub.attributes }, headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should update a hub if authenticated as admin" do
      patch v1_hub_path(hubs.first.id), params: { hub: new_hub.attributes }, headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("hub")
    end
  end

  context "DELETE /hubs/:id" do
    it "should not delete a hub if not authenticated" do
      delete v1_hub_path(hubs.first.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not delete a hub if authenticated as hub" do
      delete v1_hub_path(hubs.first.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not delete a hub if authenticated as user" do
      delete v1_hub_path(hubs.first.id), headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should delete a hub if authenticated as admin" do
      delete v1_hub_path(hubs.first.id), headers: admin_auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
