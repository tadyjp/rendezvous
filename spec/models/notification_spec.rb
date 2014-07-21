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

require 'rails_helper'

describe Notification do
  describe 'Instance method' do
    let(:bob) { create(:bob) }
    let(:charley) { create(:charley) }
    let(:post) { create(:post) }

    it "notifies on post edited" do
      bob.watch!(post: post)
      post.update!(title: post.title + ' [New!]')
      expect(bob.notifications.size).to eq(1)
    end

    it "notifies on post commented" do
      bob.watch!(post: post)
      post.comments.build(comment_params.merge(author: charley))
      expect(bob.notifications.size).to eq(1)
    end

    it "set watch on user create a new post" do
      new_post = Post.create!(author: bob, title: 'title', body: 'body')
      expect(bob.watching?(post: new_post)).to be_truthy
    end

    it "set watch on user edit a post" do
      post.update!(author: bob, title: 'new title')
      expect(bob.watching?(post: new_post)).to be_truthy
    end

    it "set watch on user comment a post" do
      post.comments.build(comment_params.merge(author: bob))
      expect(bob.watching?(post: new_post)).to be_truthy
    end
  end
end
