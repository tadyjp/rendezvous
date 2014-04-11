class LikesController < ApplicationController
  before_action :require_login

  def like
    @post = Post.find(params[:post_id])
    model = Like.new
    model[:post_id] = @post.id
    model[:user_id] = current_user.id
    if model.save()
      render layout: false, partial: 'posts/boxlike'
    else
      render :json => { :result=>"failed", :error=>model.errors, :post_id=>@post.id }
    end
  end

  def unlike
    @post = Post.find(params[:post_id])
    if Like.destroy_all(:post_id => @post.id, :user_id => current_user.id)
      render layout: false, partial: 'posts/boxlike'
    else
      render :json => { :result=>"failed", :error=>"Cannot unlike a post", :post_id=>@post.id }
    end
  end

end