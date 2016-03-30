Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Logging
  config.log_level = :debug

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Default URL options
  config.action_mailer.default_url_options = { host: 'https://dev.api.stratusprint.com' }

  # Enable mail sending
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :authentication => :plain,
    :address => "smtp.mailgun.org",
    :port => 587,
    :domain => "mg.stratusprint.com",
    :user_name => ENV["smtp_username"],
    :password => ENV["smtp_password"]
  }

  # CORS
  config.middleware.insert_before 0, "Rack::Cors" do
    allow do
      origins '*'
      resource '*', :headers => :any, :methods => [:get, :post, :options, :delete, :patch, :put], :expose => ['access-token', 'token-type', 'uid', 'client', 'expiry']
    end
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Prettify JSON responses
  config.middleware.use PrettyJsonResponse

  # Devise token auth configuration
  DeviseTokenAuth.setup do |config|
    # Don't change auth headers after each request while in development
    # mode (for testing convenience).
    config.change_headers_on_each_request = false
    # By default this value is expected to be sent by the client so that the API knows
    # where to redirect users after successful email confirmation. If this param is set,
    # the API will redirect to this value when no value is provided by the client.
    default_confirm_success_url = 'https://dev.stratusprint.com/'
  end

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
