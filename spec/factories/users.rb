FactoryGirl.define do
  factory :alice, class: User do
    email "alice@mail.com"
    password Devise.friendly_token[0,20]
    google_token_expires_at Time.now + 30.minutes
  end

  factory :bob, class: User do
    email "bob@mail.com"
    password Devise.friendly_token[0,20]
    google_token_expires_at Time.now - 1.hour
  end
end
