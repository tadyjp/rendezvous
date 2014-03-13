class WelcomeController < ApplicationController
  skip_before_action :require_login

  def top
    if user_signed_in?
      redirect_to flow_path, status: 301
    else
      render template: 'welcome/login'
    end
  end
end
