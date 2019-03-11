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

require 'rails_helper'

RSpec.describe Footprint, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
