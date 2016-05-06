class CancelJob < ApplicationJob
  queue_as :default

  def perform(job)
    @job = job
    cancel_job
  end

  private

  def cancel_job
    begin
      RestClient.delete(hub_endpoint) { |response, request, result, &block|
        case response.code
        when 200
          logger.application.info "Successfully requested that job ##{@job.id} be cancelled with the HUB."
          logger.application.debug "Response from hub: " + response
          @job.data['status'] = 'cancelled'
          @job.save
          logger.application.info "Job ##{@job.id} status set to cancelled."
        else
          logger.application.info "Unable to cancel ##{@job.id}."
        end
      }
    rescue
      # Do nothing
    end
  end

  def hub_endpoint
    "http://#{@hub.ip}:#{@hub.port}/jobs/#{@job.id}"
  end
end
