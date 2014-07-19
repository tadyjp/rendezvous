# coveralls
require 'coveralls'
Coveralls.wear!

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

require 'rspec/rails'
require 'rspec/autorun'
# require 'email_spec'
require 'factory_girl'

require 'capybara'
require 'capybara/rspec'


## Setting for polterguist.
require 'capybara/poltergeist'

def register_poltergeist(config)
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, timeout: 60, js_errors: false)
  end
  # Capybara.run_server = true
  # Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
  Capybara.default_wait_time = 10
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)


# Setting for turnip.
Dir.glob("spec/steps/**/*steps.rb") { |f| load f, true }
require 'turnip'
require 'turnip/capybara'

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.include FactoryGirl::Syntax::Methods

  # config.include(EmailSpec::Helpers)
  # config.include(EmailSpec::Matchers)

  config.before(:all) do
    FactoryGirl.reload
  end

  config.include Capybara::DSL

  config.before :suite do
    DatabaseRewinder.clean_all
  end

  # config.before :each do
  # end

  config.after :each do
    DatabaseRewinder.clean
  end

  config.include Devise::TestHelpers, :type => :controller
  # config.extend ControllerMacros, :type => :controller

  # Capybara.app_host = "http://127.0.0.1/"
  register_poltergeist(config)

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:google_oauth2, {
    'uid' => '12345',
    'provider' => 'google_oauth2',
    'info' => {'name' => 'Taro Yamada', 'email' => 'taro@zigexn.co.jp'},
    'credentials' => {'token' => 'aaaaa', 'refresh_token' => 'bbbbb', 'expires_at' => 9999999999}
  })

end
