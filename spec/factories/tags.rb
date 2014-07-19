# == Schema Information
#
# Table name: tags
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  ancestry    :string(255)
#  body        :text
#  posts_count :integer          default(0), not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag_ruby, class: Tag do
    name 'ruby'
  end

  factory :tag_java, class: Tag do
    name 'java'
  end
end
