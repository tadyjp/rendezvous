require 'spec_helper'

describe Post do

  describe 'Instance method' do
    before :each do
      @post = create(:post)
      @alice = create(:alice)
    end

    describe 'Fork' do

      subject { @post.generate_fork(@alice) }

      it 'valid title' do
        expect(subject.title).to eq('sample title')
      end

      it 'valid body' do
        expect(subject.body).to eq('sample body')
      end

      it 'valid user' do
        expect(subject.author).to eq(@alice)
      end

      it 'valid user' do
        expect(subject.tags).to include(@post.tags.first)
      end

    end
  end

  describe 'scope :search' do
    before :each do
      @alice = create(:alice)
      @post1 = Post.create id: 1001, title: 'ruby rspec', body: 'This is first espec test: ruby'
      @post2 = Post.create id: 1002, title: 'php test', body: 'PHP is very easy', author_id: @alice.id
      @post3 = Post.create id: 1003, title: 'java java...', body: 'Java is not ruby...', updated_at: Time.new(1989, 2, 25, 5, 30, 0)
      @tag_java = Tag.create(name: 'java')
      @post3.tags << @tag_java
    end

    it 'by id' do
      expect(Post.search('id:1001')).to have(1).items
      expect(Post.search('id:1001')).to include(@post1)
    end

    it 'by title' do
      expect(Post.search('title:ruby')).to have(1).items
      expect(Post.search('title:ruby')).to include(@post1)
    end

    it 'by body' do
      expect(Post.search('body:ruby')).to have(2).items
      expect(Post.search('body:ruby')).to include(@post3)
    end

    it 'by @<author_name>' do
      expect(Post.search('@Alice')).to have(1).items
      expect(Post.search('@Alice')).to include(@post2)
    end

    it 'by #<tag_name>' do
      expect(Post.search('#java')).to have(1).items
      expect(Post.search('#java')).to include(@post3)
    end

    it 'by date' do
      expect(Post.search('date:1989-2-25')).to have(1).items
      expect(Post.search('date:1989-2-25')).to include(@post3)
    end

    it 'by else' do
      expect(Post.search('ruby')).to have(2).items
      expect(Post.search('ruby')).to include(@post1)
      expect(Post.search('ruby')).to include(@post3)
    end

  end

end
