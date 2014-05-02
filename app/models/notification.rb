class Notification < ActiveRecord::Base
  belongs_to :user

  ######################################################################
  # Named scope
  ######################################################################

  # 最新のPostを取得
  scope :unread, -> {
    where(is_read: false)
  }

  ######################################################################
  # Instance method
  ######################################################################

  # 既読にする
  def set_read!
    update!(is_read: true, read_at: Time.now)
  end
end
