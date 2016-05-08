class SyncActiveJobs < ApplicationJob
  queue_as :default

  def perform(*args)
    sync_active_jobs
  end

  private

  def sync_active_jobs
    Printer.all.each do |printer|
      printer.jobs.each do |job|
        sync_job(job) if job.data['status'] != 'completed' and job.data['status'] != 'errored' and job.data['status'] != 'cancelled'
      end
    end
  end

  def sync_job(job)
    begin
      hub = job.printer.hub
      response = RestClient.get hub_job_endpoint(hub, job)
      case response.code
      when 200
        data = JSON.parse(response)
        job.data = data["data"]
        job.save!
        logger.application.info "Job ##{job.id} has been successfully synced with HUB ##{job.printer.hub.id}."
      end
    rescue
      # Do nothing
    end
  end

  def hub_job_endpoint(hub, job)
    "http://#{hub.ip}:#{hub.port}/jobs/#{job.id}"
  end
end
