# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  author_id  :integer
#  post_id    :integer
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

# FactoryGirl.define do
#   factory :comment_1, class: Comment do
#     body 'ruby'
#   end
# end
