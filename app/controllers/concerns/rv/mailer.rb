require 'mail'
require 'action_gmailer'

module RV::Mailer

  def self.compose_mail(subject, body, user)
    mail = Mail.new do
      from     user.email
      to       user.email
      subject  subject
      body     body
    end

    # set ActionGmailer
    config = {
      oauth2_token: user.google_auth_token,
      account: user.email
    }.merge(Rendezvous::Application.config.action_mailer.smtp_settings)
    mail.delivery_method(ActionGmailer::DeliveryMethod, config)

    mail
  end

end
