source 'https://rubygems.org'

gem 'puma' # Needed by AWS beanstalk
gem 'rails', '4.0.0' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'sqlite3'
gem 'turbolinks' # Needed for AWS beanstalk

group :development, :test do
    gem 'debugger'
end

group :test do
    gem 'cucumber-rails', require: false
    gem 'database_cleaner'
    gem 'autotest'
    gem 'capybara'
    gem 'rspec-rails', '3.1.0'
    gem 'webrat'
end

group :doc do
  gem 'sdoc', require: false # bundle exec rake doc:rails generates the API under doc/api.
end