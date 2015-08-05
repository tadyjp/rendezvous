source 'https://rubygems.org'

ruby '2.1.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1'

# Use SCSS for stylesheets
gem 'sass-rails', github: 'rails/sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

gem 'jquery-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'i18n_generators'

gem 'unicorn'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]

# gem 'bootstrap-sass-rails'

gem 'mysql2'

gem 'devise'

gem 'omniauth-google-oauth2'

# Markdown
gem 'github-markdown'

# Syntax Highlight
gem 'coderay'

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'thin'

  gem 'pry-rails'

  # profiler
  gem 'rack-mini-profiler'

  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  # gem 'guard-spring'
  # gem 'spring'

  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano3-unicorn'

  gem 'travis'
end

group :development, :test do
  gem 'rspec-rails'

  # gem 'database_cleaner'
  gem 'database_rewinder'

  gem 'teaspoon'
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

# compose html mail
gem 'nokogiri'
gem 'premailer'

gem 'faraday'

gem 'settingslogic'

# Check mail format
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

gem 'kaminari', github: 'amatsuda/kaminari'

gem 'jwt', '0.1.11'

# Optional

# For notifing to HipChat
gem 'hipchat'
gem 'slack-notifier', require: false

# For PDF upload
gem 'rmagick', require: 'RMagick'

# for heroku
gem 'rails_12factor', group: :production
# gem 'mysql'

# for IP restriction
gem 'rack-contrib', require: 'rack/contrib'

gem 'meta-tags'

# Growl-like Notification
# https://github.com/RobinBrouwer/gritter
gem 'gritter', '1.1.0'
