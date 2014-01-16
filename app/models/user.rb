require 'faraday'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts
  has_many :comments

  # Device
  def self.find_for_google_oauth2(access_token, signed_in_resource = nil)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(name: data['name'],
                         image_url: data['image'],
                         email: data['email'],
                         password: Devise.friendly_token[0, 20]
      )
    end

    user.update_attributes(
      google_auth_token: access_token.credentials['token'],
      google_refresh_token: access_token.credentials['refresh_token'],
      google_token_expires_at: Time.at(access_token.credentials['expires_at'])
    )

    user
  end

  # check if google oauth token is expired
  def google_oauth_token_expired?
    google_token_expires_at < Time.now
  end

  # refresh google oauth token
  def google_oauth_token_refresh!
    conn = Faraday.new(url: 'https://accounts.google.com') do |builder|
      builder.request  :url_encoded
      builder.adapter  :net_http
    end
    response = conn.post '/o/oauth2/token',
                         client_id: ENV['GOOGLE_KEY'],
                         client_secret: ENV['GOOGLE_SECRET'],
                         refresh_token: google_refresh_token,
                         grant_type: 'refresh_token'

    res_json = JSON.parse(response.body)

    update_attributes(
      google_auth_token: res_json['access_token'],
      google_token_expires_at: Time.now + res_json['expires_in'].seconds
    )
  end
end
