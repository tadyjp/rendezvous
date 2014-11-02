require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Rendezvous
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Tokyo'

    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    I18n.enforce_available_locales = true
    config.i18n.default_locale = 'ja'

    # config.action_mailer.delivery_method = :action_gmailer
    config.action_mailer.smtp_settings = {
      smtp_host:    'smtp.gmail.com',
      smtp_port:    587,
      helo_domain:  'gmail.com',
      auth_type:    :xoauth2,
      # oauth2_token: 'FIXME',
      # account:      'FIXME'
    }

    # IP restriction.
    if Rails.env.production? && ENV['RV_ALLOW_IPS']
      config.middleware.use Rack::Access,  '/' => ENV['RV_ALLOW_IPS'].split(/,/)
    end
  end
end
