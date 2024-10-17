# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.2'

gem 'bootsnap', require: false
gem 'connection_pool', '~> 2.4', '>= 2.4.1'
gem 'importmap-rails'
gem 'jbuilder'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.4'
gem 'redis', '~> 5.3'
gem 'sidekiq', '~> 7.3', '>= 7.3.2'
gem 'sidekiq-cron', '2.0.0.rc1'
gem 'sidekiq-unique-jobs', '~> 8.0', '>= 8.0.10'
gem 'sprockets-rails'
gem 'sqlite3', '>= 1.4'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
