class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2

    email = request.env['omniauth.auth'].info['email']

    # reject if email is not zigexn nor ventura.
    if email !~ /@zigexn\.co\.jp$/ && email !~ /@zigexn\.vn$/
      redirect_to root_path, flash: { alert: 'Your email address is not permitted.' }
      return
    end

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env['omniauth.auth'], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to edit_me_path
    end
  end
end
