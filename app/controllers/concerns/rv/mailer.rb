require 'mail'
require 'action_gmailer'
require 'premailer'

module RV::Mailer
  include ApplicationHelper

  def compose_mail(post, user)
    html_body = generate_html_mail(post.body)

    mail = Mail.new do
      from     user.email
      to       user.email
      subject  post.title
      body     post.body

      html_part do
        content_type 'text/html; charset=UTF-8'
        body html_body
      end
    end

    # set ActionGmailer
    config = {
      oauth2_token: user.google_auth_token,
      account: user.email
    }.merge(Rendezvous::Application.config.action_mailer.smtp_settings)
    mail.delivery_method(ActionGmailer::DeliveryMethod, config)

    mail
  end

  def generate_html_mail(body)
    path = File.expand_path(File.dirname(__FILE__) + '/mail-template.html')
    template = File.open(path).read

    html_body = template.sub('__HTML_BODY__', h_application_format_markdown(body))

    premailer = Premailer.new(html_body, with_html_string: true, adapter: :nokogiri)
    premailer.to_inline_css
  end
end
