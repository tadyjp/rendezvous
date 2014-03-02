# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag_ruby, class: Tag do
    name 'ruby'
  end

  factory :tag_java, class: Tag do
    name 'java'
  end
end
