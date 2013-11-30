class HomeController < ApplicationController

  def show
    if user_signed_in?

      if params[:q].present?
        @posts = Post.build_query(params).limit(10)
      else
        @posts = Post.order(updated_at: :desc).limit(10)
      end

      render file: 'home/app'
    else
      render file: 'home/login'
    end
  end


end
