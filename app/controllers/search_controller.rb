class SearchController < ApplicationController

  def show
    if params[:q].present?
      scope = Post.search(params[:q])
    else
      scope = Post.order(updated_at: :desc)
    end

    @count = scope.count
    @posts = scope.limit(100).decorate
  end
end
