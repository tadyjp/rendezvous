require 'faraday'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  ######################################################################
  # association
  ######################################################################
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'

  ######################################################################
  # scope
  ######################################################################
  scope :post_recently, -> {
    User.joins(:posts).group('id').order('posts.updated_at desc')
  }

  scope :search, (lambda do |_query|
    where('name LIKE ? OR nickname LIKE ?', "%#{_query}%", "%#{_query}%")
  end)


  ######################################################################
  # validations
  ######################################################################
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :nickname, presence: true
  validates :nickname, format: { with: /\A[0-9A-Za-z]+\z/i }
  validates :nickname, uniqueness: true

  # Device
  def self.find_for_google_oauth2(access_token, signed_in_resource = nil)

    user = self.where(email: access_token.info['email']).first_or_create do |_user|
      _user.name = access_token.info['name']
      _user.image_url = access_token.info['image']
      _user.password = Devise.friendly_token[0, 20]
      _user.nickname = (("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a).shuffle[0..4].join
    end

    user.update(
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
                         client_id: Settings.google_api.client_id,
                         client_secret: Settings.google_api.secret,
                         refresh_token: google_refresh_token,
                         grant_type: 'refresh_token'

    res_json = JSON.parse(response.body)

    update_attributes(
      google_auth_token: res_json['access_token'],
      google_token_expires_at: Time.now + res_json['expires_in'].seconds
    )
  end



end
