require 'test_helper'

class SensorDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sensor_datum = sensor_data(:one)
  end

  test "should get index" do
    get sensor_data_url
    assert_response :success
  end

  test "should create sensor_datum" do
    assert_difference('SensorDatum.count') do
      post sensor_data_url, params: { sensor_datum: { data: @sensor_datum.data, type: @sensor_datum.type } }
    end

    assert_response 201
  end

  test "should show sensor_datum" do
    get sensor_datum_url(@sensor_datum)
    assert_response :success
  end

  test "should update sensor_datum" do
    patch sensor_datum_url(@sensor_datum), params: { sensor_datum: { data: @sensor_datum.data, type: @sensor_datum.type } }
    assert_response 200
  end

  test "should destroy sensor_datum" do
    assert_difference('SensorDatum.count', -1) do
      delete sensor_datum_url(@sensor_datum)
    end

    assert_response 204
  end
end
