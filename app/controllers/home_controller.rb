class HomeController < ApplicationController

  def show
    if user_signed_in?
      @latest_posts = Post.last(10)
      render file: 'home/app'
    else
      render file: 'home/login'
    end
  end

end
