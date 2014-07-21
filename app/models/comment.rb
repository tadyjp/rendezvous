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
  belongs_to :author, class_name: 'User'
  belongs_to :post

  ######################################################################
  # validations
  ######################################################################
  validates :author_id, presence: true
  validates :post_id, presence: true
  validates :body, presence: true

  ######################################################################
  # Callback
  ######################################################################
  after_save :notify_author

  ######################################################################
  # Instance method
  ######################################################################
  private

  def notify_author
    post.author.push_notification(post.decorate.show_path, "#{author.name}さんがあなたの投稿にコメントしました")
  end
end
