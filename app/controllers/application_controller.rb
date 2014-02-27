class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    unless user_signed_in?
      flash[:alert] = 'You need Login!'
      session[:login_redirect_to] = request.url
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource)
    session[:login_redirect_to] || request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    render text: "Required parameter missing: #{parameter_missing_exception.param}", status: :bad_request
  end
end
