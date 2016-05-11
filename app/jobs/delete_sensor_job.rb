class DeleteSensorJob < ApplicationJob
  queue_as :default

  def perform(hub, sensor_id)
    @hub = hub
    @sensor_id = sensor_id
    delete_sensor
  end

  private

  def delete_sensor
    # Set number of max retries
    @max_retries = 3

    begin
      RestClient.delete(hub_endpoint) { |response, request, result, &block|
        case response.code
        when 200
          logger.application.info "Successfully deleted sensor ##{@sensor_id} in the HUB."
          logger.application.debug "Response from hub: " + response
        else
          logger.application.info "Unable to delete sensor ##{@sensor_id}. Received response code #{response.code} from the HUB."
        end
      }
    rescue
      @retries ||= 0
      set_job_cancelled if @retries == 0
      if @retries < @max_retries
        logger.application.info "Unable to contact HUB to delete sensor ##{@sensor_id}. Beginning retry ##{@retries}."
        @retries += 1
        retry
      end
    end
  end

  def hub_endpoint
    "http://#{@hub.ip}:#{@hub.port}/sensors/#{@sensor_id}"
  end
end
