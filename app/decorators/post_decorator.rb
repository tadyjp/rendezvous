class PostDecorator < Draper::Decorator
  delegate_all

  def show_path
    h.post_path(model)
  end

end
