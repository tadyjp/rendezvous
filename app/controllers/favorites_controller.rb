class FavoritesController < ApplicationController
  before_action :require_login

  def show
    @posts = Post.joins(:favorites).where(favorites: {user_id: current_user.id}).order(updated_at: :desc).limit(20).decorate
  end

  def favorite
    @post = Post.find(params[:post_id])
    model = Favorite.new
    model[:post_id] = @post.id
    model[:user_id] = current_user.id
    if model.save()
      render layout: false, partial: 'posts/boxfavorite'
    else
      render :json => { :result => "failed", :error => model.errors, :post_id => @post.id }
    end
  end

  def unfavorite
    @post = Post.find(params[:post_id])
    if Favorite.destroy_all(:post_id => @post.id, :user_id => current_user.id)
      render layout: false, partial: 'posts/boxfavorite'
    else
      render :json => { :result => "failed", :error => "Cannot unfavorite a post", :post_id => @post.id }
    end
  end

end