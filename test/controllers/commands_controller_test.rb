require 'test_helper'

class CommandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @command = commands(:one)
  end

  test "should get index" do
    get commands_url
    assert_response :success
  end

  test "should create command" do
    assert_difference('Command.count') do
      post commands_url, params: { command: {  } }
    end

    assert_response 201
  end

  test "should show command" do
    get command_url(@command)
    assert_response :success
  end

  test "should update command" do
    patch command_url(@command), params: { command: {  } }
    assert_response 200
  end

  test "should destroy command" do
    assert_difference('Command.count', -1) do
      delete command_url(@command)
    end

    assert_response 204
  end
end
