# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  read_at     :datetime
#  is_read     :boolean          default(FALSE), not null
#  detail_path :string(255)
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Notification < ActiveRecord::Base
  belongs_to :user

  ######################################################################
  # Named scope
  ######################################################################

  scope :unread, (lambda do
    where(is_read: false)
  end)

  scope :recent, (lambda do
    where(arel_table[:created_at].gt 7.day.ago)
  end)

  ######################################################################
  # Instance method
  ######################################################################

  # 既読にする
  def set_read!
    update!(is_read: true, read_at: Time.now)
  end
end
