source 'https://rubygems.org'

gem 'puma' # Needed by AWS beanstalk
gem 'rails', '4.0.0' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'jquery-rails' # Use jquery as the JavaScript library

group :production do
    gem 'pg'
end

group :development, :test do
    gem 'debugger'
    gem 'sqlite3'

end

group :test do
    gem 'cucumber-rails'
    gem 'database_cleaner'
    gem 'autotest'
    gem 'capybara'
    gem 'rspec-rails'
    gem 'webrat'
end

group :doc do
  gem 'sdoc', require: false # bundle exec rake doc:rails generates the API under doc/api.
end