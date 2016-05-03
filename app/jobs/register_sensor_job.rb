class RegisterSensorJob < ApplicationJob
  queue_as :default

  def perform(sensor, hub)
    @sensor = sensor
    @hub = hub
    register_sensor
  end

  private

  def hub_endpoint
    "http://#{@hub.ip}:#{@hub.port}/nodes/#{@sensor.node_id}/sensors"
  end

  def register_sensor
    RestClient.post(hub_endpoint, {:id => @sensor.id, :pin => @sensor.pin, :sensor_type => @sensor.category}.to_json, :content_type => :json, :accept => :json) { |response, request, result, &block|
      case response.code
      when 201
        logger.application.info "Sensor ##{@sensor.id} (#{@sensor.name}) successfully registered with hub ##{@hub.id}."
        logger.application.debug "Response from hub: " + response
      else
        logger.application.info "Unable to register ##{@sensor.id} (#{@sensor.name}) with hub ##{@hub.id}."
      end
    }
  end
end
