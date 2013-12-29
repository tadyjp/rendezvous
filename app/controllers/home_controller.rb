class HomeController < ApplicationController

  skip_before_action :require_login

  def top
    if user_signed_in?
      redirect_to posts_path, status: 301
    else
      render template: 'home/login'
    end
  end


end
