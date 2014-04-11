module FavoritesHelper

  def favorites_by_post(post_id)
    Favorite.get_by_post(post_id)
  end

  def is_user_favorited_post(post_id)
    Favorite.is_user_favorited_post(post_id, current_user.id)
  end

end