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

require 'rails_helper'
require 'date'

describe Post do

  describe 'Instance method' do
    before :each do
      @post = create(:post)
      @bob = create(:bob)
      @new_post = @post.generate_fork(@bob)
      @new_post.save
    end

    describe 'Fork' do

      it 'duplicated' do
        expect(@new_post.id).not_to eq(@post.id)
      end

      it 'valid title' do
        expect(@new_post.title).to eq('sample title')
      end

      it 'valid body' do
        expect(@new_post.body).to eq('sample body')
      end

      it 'valid user' do
        expect(@new_post.author).to eq(@bob)
      end

      it 'valid user' do
        expect(@new_post.tags).to include(@post.tags.first)
      end

      it 'valid specified_date' do
        expect(@new_post.specified_date).to eq(Date.today)
      end

    end
  end

  describe 'scope :search' do
    before :each do
      @alice = create(:alice)
      @author = create(:author)
      @post1 = Post.create id: 1001, author: @alice, title: 'ruby rspec', body: 'This is first espec test: ruby'
      @post2 = Post.create id: 1002, author: @alice, title: 'php test', body: 'PHP is very easy'
      @post3 = Post.create id: 1003, author: @author, title: 'java java...', body: 'Java is not ruby...', updated_at: Time.new(1989, 2, 25, 5, 30, 0)
      @post4 = Post.create id: 1004, author: @author, title: 'about ruby TDD', body: 'test is the best ....', is_draft: true
      @tag_java = Tag.create(name: 'java')
      @post3.tags << @tag_java
    end

    it 'by id' do
      expect(Post.search('id:1001').size).to eq(1)
      expect(Post.search('id:1001')).to include(@post1)
    end

    it 'by title' do
      expect(Post.search('title:ruby').size).to eq(2)
      expect(Post.search('title:ruby')).to include(@post1)
    end

    it 'by body' do
      expect(Post.search('body:ruby').size).to eq(2)
      expect(Post.search('body:ruby')).to include(@post3)
    end

    it 'by @<author_name>' do
      expect(Post.search('@Alice').size).to eq(2)
      expect(Post.search('@Alice')).to include(@post2)
    end

    it 'by #<tag_name>' do
      expect(Post.search('#java').size).to eq(1)
      expect(Post.search('#java')).to include(@post3)
    end

    it 'by date' do
      expect(Post.search('date:1989-2-25').size).to eq(1)
      expect(Post.search('date:1989-2-25')).to include(@post3)
    end

    it 'by draft' do
      expect(Post.search('ruby').size).to eq(3)
      expect(Post.search('ruby draft:1').size).to eq(1)
    end

    it 'by else' do
      expect(Post.search('ruby').size).to eq(3)
      expect(Post.search('ruby')).to include(@post1)
      expect(Post.search('ruby')).to include(@post3)
    end
  end

  describe '#notify_watchers' do
    before :each do
      @alice = create(:alice)
      @bob = create(:bob)
      @post = @alice.posts.create id: 1001, title: 'ruby rspec', body: 'This is first espec test: ruby'
    end

    it do
      @post.watchers << @bob
      @post.reload
      expect(@bob.watching_posts.size).to eq(1)
      expect(@bob.notifications.size).to eq(0)
      @post.update!(title: @post.title + '+')
      @bob.reload
      expect(@bob.notifications.size).to eq(1)
    end
  end
end
