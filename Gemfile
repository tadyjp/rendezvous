source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.2'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

gem 'jquery-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
# gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'i18n_generators'

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
gem 'redcarpet', :git => 'git://github.com/vmg/redcarpet.git',
                 :branch => "master"

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

  # rubocop
  gem 'rubocop'
  gem 'guard-rubocop'
  gem 'guard-spring'
  gem 'spring'

  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rbenv', '~> 2.0'
end

group :development, :test do
  gem 'rspec-rails'

  # gem 'database_cleaner'
  gem 'database_rewinder'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  gem 'coveralls', :require => false
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

# Check mail format
gem 'validates_email_format_of'
