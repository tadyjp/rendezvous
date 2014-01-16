class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true
  validates :body, presence: true
end
