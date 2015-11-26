source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '4.2.0'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'therubyracer', platforms: :ruby
# gem 'jbuilder'
gem 'i18n_generators'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'mysql2', '~> 0.3.20'
gem 'devise'
gem 'omniauth-google-oauth2'

gem 'github-markdown'
gem 'coderay'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'rack-mini-profiler'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'

  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rbenv', '~> 2.0'

  gem 'travis'
end

group :development, :test do
  gem 'rspec-rails'
  # gem 'database_cleaner'
  gem 'database_rewinder'
  gem 'teaspoon'
  gem 'teaspoon-mocha'
  gem 'guard-teaspoon'
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'rubocop'
  gem 'quiet_assets'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  gem 'coveralls', require: false
  gem 'turnip'
end

# tree structure
gem 'ancestry'

# Send mail via gmail oauth
# ref. https://github.com/popgiro/action-gmailer
gem 'mail'
gem 'action-gmailer', github: 'popgiro/action-gmailer'

gem 'nokogiri'
gem 'premailer'
gem 'faraday'
gem 'settingslogic'
gem 'validates_email_format_of'

# Presentaion layer
gem 'draper', '~> 1.3'

# ActiveRecord versioning
gem 'paper_trail', '~> 3.0.0'

gem 'aws-sdk', '1.39.0'

gem 'newrelic_rpm'

gem 'breadcrumble'

gem 'slim'

gem 'annotate', '>=2.6.0'

gem 'kaminari'

gem 'jwt', '0.1.11'

# Optional

# For notifing to HipChat
gem 'hipchat'

# for PDF upload
gem 'rmagick'

group :production do
  # for heroku
  gem 'rails_12factor'
  gem 'puma'
end

# for IP restriction
gem 'rack-contrib', require: 'rack/contrib'

gem 'meta-tags'

# Growl-like Notification
# https://github.com/RobinBrouwer/gritter
gem 'gritter', '1.1.0'
