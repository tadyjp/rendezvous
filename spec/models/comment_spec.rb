require 'spec_helper'

describe Comment do
  describe 'validations' do
    it 'blank author_id' do
      expect(Comment.new(post_id: 1, body: 'test')).not_to be_valid
    end

    it 'blank post_id' do
      expect(Comment.new(author_id: 1, body: 'test')).not_to be_valid
    end

    it 'blank body' do
      expect(Comment.new(post_id: 1, author_id: 2)).not_to be_valid
    end
  end
end
