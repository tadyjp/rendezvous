# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  body           :text
#  author_id      :integer
#  created_at     :datetime
#  updated_at     :datetime
#  is_draft       :boolean          default(FALSE)
#  specified_date :date
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :post do
    title 'sample title'
    body 'sample body'
    specified_date Date.new(2014, 4, 1)

    after(:create) do |post|
      create(:post_tag, post: post, tag: create(:tag_ruby))
    end
  end

  factory :post_tag do
  end
end
