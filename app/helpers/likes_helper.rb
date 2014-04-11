module LikesHelper

  def likes_by_post(post_id)
    Like.get_by_post(post_id)
  end

  def is_user_liked_post(post_id)
    Like.is_user_liked_post(post_id, current_user.id)
  end

end