class FlowController < ApplicationController
  def show
    @posts = Post.includes(:tags, :author).where(is_draft: false).order(updated_at: :desc).page(params[:page]).decorate
  end
end
