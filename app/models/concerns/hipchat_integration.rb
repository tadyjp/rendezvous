module HipchatIntegration
  # Call Hipchat API
  def notify_hipchat!
    client = HipChat::Client.new(Settings.hipchat.token)
    client[Settings.hipchat.room].send('Rendezvous', notify_hipchat_body, message_format:'text', notify: 1)
  end

  # @return [String] notification body
  def notify_hipchat_body
    <<EOF
#{author.name}が「#{title}」を投稿しました。
#{self.decorate.show_url}
--
#{body}
EOF
  end
end
