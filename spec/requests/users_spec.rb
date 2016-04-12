require "rails_helper"

describe "User Management", :type => :request do
  let!(:users) { create_list(:user, 5) }
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:new_user) { build :user }
  let(:admin_auth_headers) { admin.create_new_auth_token }
  let(:user_auth_headers) { user.create_new_auth_token }

  context "GET /users" do
    it "should not return a list of all users if not authenticated" do
      get v1_users_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not return a list of all users if authenticated as user" do
      get v1_users_path, headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a list of all users if authenticated as admin" do
      get v1_users_path, headers: admin_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(users.length + 1)
    end
  end

  context "GET /users/:id" do
    it "should not return a user if not authenticated" do
      get v1_user_path(user.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not return a user if authenticated as that user" do
      get v1_user_path(user.id), headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not return a user if not authenticated as that user" do
      get v1_user_path(users.first.id), headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a user if authenticated as admin" do
      get v1_user_path(user.id), headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("user")
    end
  end

  context "DELETE /users/:id" do
    it "should not delete a user if not authenticated" do
      delete v1_user_path(user.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not delete a user if authenticated as that user" do
      delete v1_user_path(user.id), headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not delete a user if not authenticated as that user" do
      delete v1_user_path(users.first.id), headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should delete a user if authenticated as admin" do
      delete v1_user_path(user.id), headers: admin_auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end

  context "PATCH /users/:id" do
    it "should not update a user if not authenticated" do
      patch v1_user_path(user.id), params: { user: new_user.attributes }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not update a user if authenticated as that user" do
      patch v1_user_path(user.id), headers: user_auth_headers, params: { user: new_user.attributes }
      expect(response).to have_http_status(:forbidden)
    end

    it "should not update a user if not authenticated as that user" do
      patch v1_user_path(users.first.id), headers: user_auth_headers, params: { user: new_user.attributes }
      expect(response).to have_http_status(:forbidden)
    end

    it "should update a user if authenticated as admin" do
      patch v1_user_path(user.id), headers: admin_auth_headers, params: { user: new_user.attributes }
      expect(response).to have_http_status(:success)
    end
  end
end
