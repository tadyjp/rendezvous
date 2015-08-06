module SlackIntegration
  extend ActiveSupport::Concern

  included do
    after_create :notify_create! if Settings.slack.webhook_url.present?
    after_update :notify_update! if Settings.slack.webhook_url.present?
  end

  def notify_create!
    return if is_draft
    send_to_slack(summary, notify_slack_body)
  end

  def notify_update!
    return if is_draft
    send_to_slack("#{author.name}が「<#{decorate.show_url}|#{title}>」を更新しました。")
  end

  def send_to_slack(message, attach = nil)
    require 'slack-notifier'

    client = Slack::Notifier.new (Settings.slack.webhook_url)

    if attach
      client.ping message, attachments: attach
    else
      client.ping message
    end
  end

  def summary
    "#{author.name}が「<#{decorate.show_url}|#{title}>」を投稿しました。"
  end

  def notify_slack_body
    [{
       fallback: summary,
       fields: [
         value: body,
         short: true
       ],
       color: 'good'
     }]
  end
end
