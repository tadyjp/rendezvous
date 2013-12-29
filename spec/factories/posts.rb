# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title 'sample title'
    body 'sample body'

    after(:create) do |post|
      create(:post_tag, post: post, tag: create(:tag_ruby))
    end
  end

  factory :post_tag do
  end

end
