class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    unless user_signed_in?
      flash[:alert] = 'You need Login!'
      redirect_to root_path
    end
  end

end
