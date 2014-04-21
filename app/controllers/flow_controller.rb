class FlowController < ApplicationController

  def show
    @posts = Post.includes(:tags, :author).where(is_draft: false).order(updated_at: :desc).limit(20).decorate
  end
end
