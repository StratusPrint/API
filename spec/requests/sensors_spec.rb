require "rails_helper"

describe "Sensor Management", :type => :request do
  let!(:hubs) { create_list(:hub, 3) }
  let(:sensor) { hubs.first.sensors.first }
  let(:new_sensor) { build :sensor }
  let(:new_data_point) { build :temperature_data_point }
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:admin_auth_headers) { admin.create_new_auth_token }
  let(:user_auth_headers) { user.create_new_auth_token }
  let(:hub_auth_headers) { hubs.first.create_new_auth_token }

  context "GET /hubs/:id/sensors" do
    it "should not return a hub's sensors if not authenticated" do
      get v1_hub_sensors_path(hubs.first.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not return a hub's sensors if not authenticated as that hub" do
      get v1_hub_sensors_path(hubs.second.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a hub's sensors if authenticated as that hub" do
      get v1_hub_sensors_path(hubs.first.id), headers: hub_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(hubs.first.sensors.length)
    end

    it "should return a hub's sensors if authenticated as admin" do
      get v1_hub_sensors_path(hubs.first.id), headers: admin_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(hubs.first.sensors.length)
    end

    it "should return a hub's sensors if authenticated as user" do
      get v1_hub_sensors_path(hubs.first.id), headers: user_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(hubs.first.sensors.length)
    end
  end

  context "POST /hubs/:id/sensors" do
    it "should not create a new sensor if not authenticated" do
      post v1_hub_sensors_path(hubs.first.id), params: { sensor: new_sensor.attributes }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not create a new sensor if not authenticated as parent hub" do
      post v1_hub_sensors_path(hubs.second.id), params: { sensor: new_sensor.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should create a new sensor if authenticated as parent hub" do
      post v1_hub_sensors_path(hubs.first.id), params: { sensor: new_sensor.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:created)
    end

    it "should not create a new sensor if authenticated as user" do
      post v1_hub_sensors_path(hubs.first.id), params: { sensor: new_sensor.attributes }, headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should create a new sensor if authenticated as admin" do
      post v1_hub_sensors_path(hubs.first.id), params: { sensor: new_sensor.attributes }, headers: admin_auth_headers
      expect(response).to have_http_status(:created)
      expect(response).to match_response_schema("sensor")
    end
  end

  context "DELETE /sensors/:id" do
    it "should not delete a sensor if not authenticated" do
      delete v1_sensor_path(sensor.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not delete a new sensor if authenticated as hub" do
      delete v1_sensor_path(sensor.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should not delete a sensor if authenticated as user" do
      delete v1_sensor_path(sensor.id), headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should delete a sensor if authenticated as admin" do
      delete v1_sensor_path(sensor.id), headers: admin_auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end

  context "GET /sensors/:id" do
    it "should not return a sensor if not authenticated" do
      get v1_sensor_path(sensor.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not return a sensor if not authenticated as parent hub" do
      get v1_sensor_path(hubs.second.sensors.first.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a sensor if authenticated as parent hub" do
      get v1_sensor_path(sensor.id), headers: hub_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("sensor")
    end

    it "should return a sensor if authenticated as user" do
      get v1_sensor_path(sensor.id), headers: user_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("sensor")
    end

    it "should return a sensor if authenticated as admin" do
      get v1_sensor_path(sensor.id), headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("sensor")
    end
  end

  context "PATCH /sensors/:id" do
    it "should not update a sensor if not authenticated" do
      patch v1_sensor_path(sensor.id), params: { sensor: new_sensor.attributes }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not update a sensor if not authenticated as parent hub" do
      patch v1_sensor_path(hubs.second.sensors.first.id), params: { sensor: new_sensor.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should update a sensor if authenticated as parent hub" do
      patch v1_sensor_path(sensor.id), params: { sensor: new_sensor.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("sensor")
    end

    it "should not update a sensor if authenticated as user" do
      patch v1_sensor_path(sensor.id), params: { sensor: new_sensor.attributes }, headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should update a sensor if authenticated as admin" do
      patch v1_sensor_path(sensor.id), params: { sensor: new_sensor.attributes }, headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("sensor")
    end
  end

  context "GET /sensors/:id/data" do
    it "should not return data points if not authenticated" do
      get v1_sensor_data_path(sensor.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not return data points if not authenticated as parent hub" do
      get v1_sensor_data_path(hubs.second.sensors.first.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return data points if authenticated as parent hub" do
      get v1_sensor_data_path(sensor.id), headers: hub_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(sensor.data_points.length)
    end

    it "should return data points if authenticated as user" do
      get v1_sensor_data_path(sensor.id), headers: user_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(sensor.data_points.length)
    end

    it "should return data points if authenticated as user" do
      get v1_sensor_data_path(sensor.id), headers: admin_auth_headers
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(sensor.data_points.length)
    end
  end

  context "POST /sensors/:id/data" do
    it "should not add a data point if not authenticated" do
      post v1_sensor_data_path(sensor.id), params: { data_point: new_data_point.attributes }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not add a data point if not authenticated as parent hub" do
      post v1_sensor_data_path(hubs.second.sensors.first.id), params: { data_point: new_data_point.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should add a data point if authenticated as parent hub" do
      post v1_sensor_data_path(sensor.id), params: { data_point: new_data_point.attributes }, headers: hub_auth_headers
      expect(response).to have_http_status(:created)
    end

    it "should not add a data point if authenticated as user" do
      post v1_sensor_data_path(sensor.id), params: { data_point: new_data_point.attributes }, headers: user_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should add a data point if authenticated as admin" do
      post v1_sensor_data_path(sensor.id), params: { data_point: new_data_point.attributes }, headers: admin_auth_headers
      expect(response).to have_http_status(:created)
    end
  end

  context "GET /data/:id" do
    it "should not return a data point if not authenticated" do
      get v1_datum_path(sensor.data_points.first.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not return a data point if not authenticated as parent hub" do
      get v1_datum_path(hubs.second.sensors.first.data_points.first.id), headers: hub_auth_headers
      expect(response).to have_http_status(:forbidden)
    end

    it "should return a data point if authenticated as parent hub" do
      get v1_datum_path(sensor.data_points.first.id), headers: hub_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("data_point")
    end

    it "should return a data point if authenticated as user" do
      get v1_datum_path(sensor.data_points.first.id), headers: user_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("data_point")
    end

    it "should return a data point if authenticated as admin" do
      get v1_datum_path(sensor.data_points.first.id), headers: admin_auth_headers
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("data_point")
    end
  end
end
