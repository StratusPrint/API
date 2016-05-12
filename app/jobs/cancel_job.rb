class CancelJob < ApplicationJob
  queue_as :default

  def perform(job)
    @job = job
    @hub = job.printer.hub
    cancel_job
  end

  private

  def cancel_job
    # Set number of max retries
    @max_retries = 3

    begin
      RestClient.delete(hub_endpoint) { |response, request, result, &block|
        case response.code
        when 200
          logger.application.info "Successfully requested that job ##{@job.id} be cancelled with the HUB."
          logger.application.debug "Response from hub: " + response
          set_job_cancelled
        else
          logger.application.info "Unable to cancel ##{@job.id}. Received response code #{response.code} from the HUB. Perhaps the model has not been sent to the HUB yet?"
        end
      }
    rescue
      @retries ||= 0
      set_job_cancelled if @retries == 0
      if @retries < @max_retries
        logger.application.info "Unable to contact HUB to cancel job ##{@job.id}. Beginning retry ##{@retries}."
        @retries += 1
        retry
      end
    end
  end

  def set_job_cancelled
    @job.data['status'] = 'cancelled'
    @job.save
    logger.application.info "Job ##{@job.id} status set to cancelled."
    CreateAlertJob.perform_later(@job, 'cancelled', 'processing')
  end

  def hub_endpoint
    "http://#{@hub.ip}:#{@hub.port}/jobs/#{@job.id}"
  end
end
