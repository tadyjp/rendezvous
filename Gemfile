source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
# gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# gem 'bootstrap-sass-rails'

gem 'devise'
gem 'omniauth-google-oauth2'

# Markdown
gem 'redcarpet', :git => 'git://github.com/vmg/redcarpet.git',
                 :branch => "master"

# Syntax Highlight
gem 'coderay'

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'thin'

  # gem 'capistrano', '~> 3.0.1'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end

# tree structure
gem 'ancestry'

# profiler
gem 'rack-mini-profiler'

# Send mail via gmail oauth
# ref. https://github.com/popgiro/action-gmailer
gem 'mail'
gem 'action-gmailer', github: 'popgiro/action-gmailer'
