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
