require 'test_helper'

class SensorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sensor = sensors(:one)
  end

  test "should get index" do
    get sensors_url
    assert_response :success
  end

  test "should create sensor" do
    assert_difference('Sensor.count') do
      post sensors_url, params: { sensor: { data: @sensor.data, desc: @sensor.desc, id: @sensor.id, label: @sensor.label, last_communication_recv: @sensor.last_communication_recv, type: @sensor.type } }
    end

    assert_response 201
  end

  test "should show sensor" do
    get sensor_url(@sensor)
    assert_response :success
  end

  test "should update sensor" do
    patch sensor_url(@sensor), params: { sensor: { data: @sensor.data, desc: @sensor.desc, id: @sensor.id, label: @sensor.label, last_communication_recv: @sensor.last_communication_recv, type: @sensor.type } }
    assert_response 200
  end

  test "should destroy sensor" do
    assert_difference('Sensor.count', -1) do
      delete sensor_url(@sensor)
    end

    assert_response 204
  end
end
