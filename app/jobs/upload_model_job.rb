class UploadModelJob < ApplicationJob
  include ::CarrierWave::Workers::ProcessAssetMixin
  queue_as :default

  after_perform do |j|
    # Retrieve Job, Printer, and Hub from database
    begin
      @job = Job.find(j.arguments.second.to_i)
      @printer = @job.printer
      @hub = @printer.hub
    rescue
      retry_job
    end

    # Set model as processing. This flag indicates that model
    # for a job is currently being processed in a background job.
    set_model_processing

    # Set number of max retries
    @max_retries = 6

    # Make the POST request. This will try to send the model file to the hub at most 6 times
    # should the initial POST request fail.
    logger.application.info "Sending job number #{@job.id} with model file #{@job.model} to hub for printing."

    begin
      RestClient.post(hub_endpoint, :file => File.new(@job.model.current_path), :id => @job.id) { |response, request, result, &block|
        case response.code
        when 201
          logger.application.info "Job ##{@job.id} successfully sent to hub ##{@hub.id} for printer ##{@printer.id}."
          logger.application.debug "Response from hub: " + response
          clear_model_processing
        end
      }
    rescue
      @retries ||= 0
      if @retries < @max_retries
        logger.application.info "Unable to send job ##{@job.id} to hub ##{@hub.id} for printer ##{@printer.id}. Beginning retry ##{@retries}."
        @retries += 1
        retry
      else
        set_job_errored
      end
    end
  end

  # Sometimes job gets performed before the file is uploaded and ready.
  # You can define how to handle that case by overriding `when_not_ready` method
  # (by default it does nothing)
  def when_not_ready
    retry_job
  end

  private
  def set_job_errored
    clear_model_processing
    @job.data['status'] = 'errored'
    @job.save
    CreateAlertJob.perform_later(@job, 'errored', 'processing')
    logger.application.info "Unable to send job ##{@job.id} to hub ##{@hub.id} for printer ##{@printer.id} after #{@max_retries} attempts. Setting job status to errored."
  end

  def hub_endpoint
    "http://#{@hub.ip}:#{@hub.port}/printers/#{@printer.id}/jobs"
  end

  def set_model_processing
    @job.model_processing = true
    @job.save
  end

  def clear_model_processing
    @job.model_processing = false
    @job.save
  end
end
