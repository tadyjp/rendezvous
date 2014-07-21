# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  read_at     :datetime
#  is_read     :boolean          default(FALSE), not null
#  detail_path :string(255)
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Notification do
  describe 'Instance method' do
    let(:alice) { create(:alice) }

    it "notifies on post edited" do
    end

    it "notifies on post commented" do
    end

    it "set watch on user create a new post" do
    end

    it "set watch on user edit a post" do
    end

    it "set watch on user comment a post" do
    end
  end
end
