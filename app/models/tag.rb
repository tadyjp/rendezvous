class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, through: :post_tags

  # for tree structure
  has_ancestry

  # for versioning
  has_paper_trail

  default_scope { order(:updated_at => :desc) }

  # 自分のタグに紐づくPostをすべて`other_tag`へ移動する
  def move_all_posts_to!(other_tag)
    self.posts.each do |_post|
      _post.tags.delete(self)
      _post.tags << other_tag unless _post.tags.include?(other_tag)
    end
  end
end
