# == Schema Information
#
# Table name: footprints
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  post_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Footprint < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end
