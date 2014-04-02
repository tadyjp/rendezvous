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

FactoryGirl.define do
  factory :alice, class: User do
    name 'Alice'
    email 'alice@mail.com'
    nickname 'alice'
    password Devise.friendly_token[0, 20]
    google_token_expires_at Time.now + 30.minutes
  end

  factory :bob, class: User do
    name 'Bob'
    email 'bob@mail.com'
    nickname 'bob'
    password Devise.friendly_token[0, 20]
    google_token_expires_at Time.now - 1.hour
  end

  factory :login_user_1, class: User do
    name 'Test User'
    email 'example@example.com'
    nickname 'testuser'
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
