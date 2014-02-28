class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, through: :post_tags

  has_ancestry

  default_scope { order(:updated_at => :desc) }
end
