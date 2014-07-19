class WatchingsController < ApplicationController
  def show
    @posts = current_user.watching_posts.order(updated_at: :desc).page(params[:page]).decorate
  end
end
