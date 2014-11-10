# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  image_url               :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  google_auth_token       :string(255)
#  google_refresh_token    :string(255)
#  google_token_expires_at :datetime
#  nickname                :string(255)      default(""), not null
#

require 'faraday'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  ######################################################################
  # Associations
  ######################################################################
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :notifications
  has_many :footprints

  has_many :watchings, class_name: 'Watch', foreign_key: 'watcher_id'
  has_many :watching_posts, through: :watchings, source: :watchable, source_type: 'Post'

  ######################################################################
  # scope
  ######################################################################
  scope :post_recently, (lambda do
    User.joins(:posts).group('id').order('posts.updated_at desc')
  end)

  scope :search, (lambda do |query|
    where('name LIKE ? OR nickname LIKE ?', "%#{query}%", "%#{query}%")
  end)

  scope :post_today, -> { joins(:posts).where('posts.updated_at > ?', 1.day.ago) }

  scope :now_viewing, -> { joins(:footprints).where('footprints.updated_at > ?', 10.minutes.ago).group('users.id') }

  ######################################################################
  # Validations
  ######################################################################
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :nickname, presence: true
  validates :nickname, format: { with: /\A[0-9A-Za-z]+\z/i }
  validates :nickname, uniqueness: true

  # Device
  def self.find_for_google_oauth2(access_token, _signed_in_resource = nil)
    user = where(email: access_token.info['email']).first_or_create do |u|
      u.name = access_token.info['name']
      u.image_url = access_token.info['image']
      u.password = Devise.friendly_token[0, 20]
      u.nickname = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).shuffle[0..4].join
    end

    user.update(
      google_auth_token: access_token.credentials['token'],
      google_refresh_token: access_token.credentials['refresh_token'],
      google_token_expires_at: Time.at(access_token.credentials['expires_at'])
    )

    user
  end

  ######################################################################
  # instance methods
  ######################################################################

  # check if google oauth token is expired
  def google_oauth_token_expired?
    google_token_expires_at < Time.now
  end

  # refresh google oauth token
  def google_oauth_token_refresh!
    conn = Faraday.new(url: 'https://accounts.google.com') do |builder|
      builder.request :url_encoded
      builder.adapter :net_http
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

  # push通知を追加
  def push_notification(detail_path, body)
    return if notifications.where(detail_path: detail_path).unread.exists?

    notifications.create(detail_path: detail_path, body: body, is_read: false)
  end

  # record footprint
  def visit_post!(post)
    footprints.create!(post: post)
  end

  def watch!(hash)
    if hash[:post]
      watching_posts << hash[:post] unless watching_posts.include?(hash[:post])
    elsif hash[:tag]
      fail 'Not Implemented.'
    elsif hash[:user]
      fail 'Not Implemented.'
    else
      fail 'No hash argument set.'
    end
  end

  def unwatch!(hash)
    if hash[:post]
      hash[:post].watches.where(watcher: self).destroy_all
    elsif hash[:tag]
      fail 'Not Implemented.'
    elsif hash[:user]
      fail 'Not Implemented.'
    else
      fail 'No hash argument set.'
    end
  end

  # check if user watching post/tag/user
  # TODO: tag/user
  def watching?(hash)
    if hash[:post]
      hash[:post].watches.where(watcher: self).exists?
    elsif hash[:tag]
      fail 'Not Implemented.'
    elsif hash[:user]
      fail 'Not Implemented.'
    else
      fail 'No hash argument set.'
    end
  end

  # def watching_posts
  #   ids = watching_items.where(resource_type: "Post").pluck(:resource_id)
  #   Post.where(id: ids)
  # end
end
