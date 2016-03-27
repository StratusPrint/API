source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta2', '< 5.1'
# Use PostgreSQL as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# Action Cable dependencies for the Redis adapter
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Data serialization
gem 'active_model_serializers', git: 'git@github.com:rails-api/active_model_serializers.git'
# User authentication
gem 'omniauth', '>= 1.0.0'
gem "devise", :github => 'plataformatec/devise', :branch => 'master'
gem 'devise_token_auth', git: 'git@github.com:StratusPrint/devise_token_auth.git'
# Resource authorization
gem 'cancancan', '~> 1.10'
# Environment variables
gem 'figaro'
# API documentation via swagger
gem 'swagger-blocks'
# CORS
gem 'rack-cors', :require => 'rack/cors'
# ActiveModel Validators
gem 'activevalidators'
gem 'enumerize'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'json-schema'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
