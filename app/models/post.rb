class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :author, class_name: 'User'
end
