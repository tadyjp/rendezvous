class SearchController < ApplicationController

  def show
    if params[:q].present?
      scope = Post.search(params[:q])
    else
      scope = Post.order(updated_at: :desc)
    end

    @count = scope.count
    @posts = scope.page(params[:page]).decorate
  end
end
