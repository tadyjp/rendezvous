class HomeController < ApplicationController

  def show
    if user_signed_in?
      render file: 'home/app'
    else
      render file: 'home/login'
    end
  end

end
