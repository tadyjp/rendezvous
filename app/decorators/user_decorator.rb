class UserDecorator < Draper::Decorator
  delegate_all

  def draft_count
    model.posts.where(is_draft: true).count
  end

  # URL for user thumbnail.
  def image_url
    model.image_url.presence || h.asset_path('face.jpg')
  end
end
