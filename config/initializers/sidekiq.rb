require 'sidekiq/web'
require 'sidekiq/cron/web'

schedule_file = "config/schedule.yml"

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.remove Sidekiq::Middleware::Server::RetryJobs
  end
end

if File.exists?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
