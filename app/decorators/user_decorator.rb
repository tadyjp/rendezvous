class UserDecorator < Draper::Decorator
  delegate_all

  def draft_count
    model.posts.where(is_draft: true).count
  end
end
