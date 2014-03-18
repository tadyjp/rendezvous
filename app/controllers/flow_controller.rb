class FlowController < ApplicationController
  before_action :require_login

  def show
    @posts = Post.where(is_draft: false).order(updated_at: :desc).limit(20).decorate
  end
end
