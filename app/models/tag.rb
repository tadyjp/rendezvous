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

  # for tree structure
  has_ancestry

  # for versioning
  has_paper_trail

  ######################################################################
  # Associations
  ######################################################################
  has_many :post_tags
  has_many :posts, through: :post_tags

  ######################################################################
  # Named scope
  ######################################################################
  default_scope { order(updated_at: :desc) }

  scope :posts_exist, lambda {
    select('tags.*, count(posts.id) as posts_count')
      .joins(:posts)
      .group('tags.id')
      .having('posts_count > 0')
  }

  scope :recently_created, (lambda do |limit = 10|
    order(created_at: :desc).limit(limit)
  end)


  ######################################################################
  # Class method
  ######################################################################
  class << self
    # 最近投稿されたTagを取得
    def recent(limit = 10)
      Post.recent(20).map(&:tags).flatten.compact.uniq.take(limit)
    end

    # TODO: cache
    def monthly_popular(limit = 10)
      tags_this_month = Hash.new { |h, k| h[k] = 0 } # { <tag.id> => <count> }
      tags_last_month = Hash.new { |h, k| h[k] = 0 } # { <tag.id> => <count> }

      Post.this_month.each do |post|
        post.tags.each { |tag| tags_this_month[tag.id] += 1 }
      end

      Post.last_month.each do |post|
        post.tags.each { |tag| tags_last_month[tag.id] += 1 }
      end

      tags_this_month_with_score = {}
      tags_this_month.each do |tag_id, this_month_count|
        next if this_month_count <= 3
        tags_this_month_with_score[tag_id] = this_month_count.to_f / (tags_last_month[tag_id] + 1)
      end

      sorted = tags_this_month_with_score.sort_by { |k, v| -v }.take(limit).to_h

      Tag.find(sorted.keys).to_a.zip(sorted.values).to_h
    end
  end

  ######################################################################
  # Instance method
  ######################################################################


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
