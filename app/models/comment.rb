# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  author_id  :integer
#  post_id    :integer
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  ######################################################################
  # Associations
  ######################################################################
  belongs_to :author, class_name: 'User'
  belongs_to :post

  ######################################################################
  # Validations
  ######################################################################
  validates :author_id, presence: true
  validates :post_id, presence: true
  validates :body, presence: true

  ######################################################################
  # Callback
  ######################################################################
  after_save :set_watcher!
  after_save :notify_watchers!

  ######################################################################
  # Instance method
  ######################################################################
  private

  def notify_watchers!
    post.watchers.each do |watcher|
      next if watcher == author

      watcher.push_notification(post.decorate.show_path, "#{author.name}さんが「#{post.title}」にコメントしました。")
    end
  end

  def set_watcher!
    author.watch!(post: post)
  end
end
