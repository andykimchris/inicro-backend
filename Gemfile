# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'rails', '~> 7.1.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

gem 'puma', '>= 5.0'

gem 'devise', '~> 4.9'
gem 'devise-jwt'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"
gem 'sidekiq', '~> 7.2'
gem 'sidekiq-cron'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'active_storage_validations'
gem 'image_processing', '~> 1.2'
gem 'ruby-vips', '>= 2.1.0'

gem 'aws-sdk-s3', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors'

gem 'google-cloud-storage', '~> 1.11', require: false
gem "rqrcode", "~> 2.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'better_errors'
  gem 'debug', platforms: %i[mri windows]
  gem 'simplecov'

  # Security tools
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'ruby_audit'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'factory_bot_rails'
  gem 'pre-commit', require: false

  # gem 'error_highlight', '>= 0.4.0', platforms: [:ruby]
end

group :test do
  gem 'byebug'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails', '~> 6.0.0'

  gem 'rspec-sidekiq'

  # Linter
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
