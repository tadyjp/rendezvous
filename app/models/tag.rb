# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  ancestry   :string(255)
#  body       :text
#

class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, through: :post_tags

  # for tree structure
  has_ancestry

  # for versioning
  has_paper_trail

  default_scope { order(:updated_at => :desc) }

  scope :posts_exist, lambda {
    select('tags.*, count(posts.id) as posts_count').
    joins(:posts).
    group('tags.id').
    having('posts_count > 0')
  }

  def recent_posts(limit = 30)
    self.posts.recent(limit)
  end

  # 自分のタグに紐づくPostをすべて`other_tag`へ移動する
  def move_all_posts_to!(other_tag)
    self.posts.each do |_post|
      _post.tags.delete(self)
      _post.tags << other_tag unless _post.tags.include?(other_tag)
    end
  end

  # 親タグを設定する
  def set_parent!(other_tag)
    self.parent = other_tag
    self.save!
  end
end
