class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :post_id, presence: true
  validates :user_id, presence: true

  def self.get_by_post(post_id)
    self.where(:post_id => post_id)
  end

  def self.is_user_favorited_post(post_id, user_id)
    self.distinct.count('id', :conditions => "post_id = #{post_id} AND user_id = #{user_id}") > 0 ? true : false
  end

end
