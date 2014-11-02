# == Schema Information
#
# Table name: tags
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  ancestry    :string(255)
#  body        :text
#  posts_count :integer          default(0), not null
#

class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, through: :post_tags

  # for tree structure
  has_ancestry

  # for versioning
  has_paper_trail

  default_scope { order(updated_at: :desc) }

  scope :posts_exist, lambda {
    select('tags.*, count(posts.id) as posts_count')
      .joins(:posts)
      .group('tags.id')
      .having('posts_count > 0')
  }

  class << self
    # 最近投稿されたTagを取得
    def recent(limit = 10)
      Post.recent(20).map(&:tags).flatten.compact.uniq.take(limit)
    end
  end

  def recent_posts(limit = 30)
    posts.recent(limit)
  end

  # 自分のタグに紐づくPostをすべて`other_tag`へ移動する
  def move_all_posts_to!(other_tag)
    posts.each do |moving_post|
      moving_post.tags.delete(self)
      moving_post.tags << other_tag unless moving_post.tags.include?(other_tag)
    end
  end

  # 親タグを設定する
  def parent_tag=(other_tag)
    self.parent = other_tag
    self.save!
  end
end
