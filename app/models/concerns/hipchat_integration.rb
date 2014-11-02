module HipchatIntegration
  # Call Hipchat API
  def notify_hipchat!
    require 'uri'

    return if is_draft

    client = HipChat::Client.new(Settings.hipchat.token)
    room = URI.unescape(Settings.hipchat.room)
    client[room].send('Rendezvous', notify_hipchat_body, message_format: 'text', notify: 1)
  end

  # @return [String] notification body
  def notify_hipchat_body
    <<EOF
#{author.name}が「#{title}」を投稿しました。
#{decorate.show_url}
--
#{body}
EOF
  end
end
