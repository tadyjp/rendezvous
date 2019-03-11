source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.5.3'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

gem 'jquery-rails', '~> 3.1.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', '~> 0.12.1', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.1.3'

gem 'i18n_generators', '~> 1.2.1'

gem 'unicorn', '~> 4.8.3'

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

gem 'mysql2', '~> 0.3.16'

gem 'devise', '~> 3.2.4'

gem 'omniauth', '~> 1.4.3'
gem 'omniauth-google-oauth2', '~> 0.6.0'

# Markdown
gem 'github-markdown', '~> 0.6.6'

# Syntax Highlight
gem 'coderay', '~> 1.1.0'

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'thin'

  gem 'pry-rails'

  # profiler
  gem 'rack-mini-profiler'

  # rubocop
  gem 'rubocop'
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
end

group :development, :test do
  gem 'rspec-rails'

  # gem 'database_cleaner'
  gem 'database_rewinder'

  gem 'teaspoon'
  gem 'teaspoon-mocha'
  gem 'guard-teaspoon'
  gem 'byebug'
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
gem 'ancestry', '~> 2.1.0'

# Send mail via gmail oauth
# ref. https://github.com/popgiro/action-gmailer
gem 'mail', '~> 2.5.4'
gem 'action-gmailer', '~> 0.1.0'

# compose html mail
gem 'nokogiri', '~> 1.6.3.1'
gem 'premailer', '~> 1.8.2'

gem 'faraday', '~> 0.9.0'

gem 'settingslogic', '~> 2.0.9'

# Check mail format
gem 'validates_email_format_of', '~> 1.5.3'

# Presentaion layer
gem 'draper', '~> 1.3'

# ActiveRecord versioning
gem 'paper_trail', '~> 3.0.0'

gem 'aws-sdk', '1.39.0'

gem 'newrelic_rpm', '~> 3.9.1.236'

gem 'breadcrumble', '~> 4.1.0'

gem 'slim', '~> 2.0.3'

gem 'annotate', "~> 2.6.5"

gem 'kaminari', '~> 1.0.0.alpha'

gem 'jwt', '>= 2.0'


# Optional

# For notifing to HipChat
gem 'hipchat', '~> 1.2.0'

# For PDF upload
gem 'rmagick', '~> 2.13.3', :require => 'RMagick'
