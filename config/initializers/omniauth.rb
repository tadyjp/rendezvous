Rails.application.config.middleware.use OmniAuth::Builder do

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
           name: 'google_oauth2',
           scope: 'https://mail.google.com/, userinfo.email, userinfo.profile',
           access_type: 'offline',
           prompt: 'select_account consent',
           image_aspect_ratio: 'square',
           image_size: 50

end
