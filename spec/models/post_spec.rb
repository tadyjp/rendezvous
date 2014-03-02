require 'spec_helper'

describe Post do

  describe 'Instance method' do
    before :each do
      @post = create(:post)
      @alice = create(:alice)
      @new_post = @post.generate_fork(@alice)
      @new_post.save
    end

    describe 'Fork' do

      # subject {
      #   @post.generate_fork(@alice).save
      # }

      it 'duplicated' do
        expect(@new_post.id).not_to eq(@post.id)
      end

      it 'valid title' do
        expect(@new_post.title).to eq('sample title のコピー')
      end

      it 'valid body' do
        expect(@new_post.body).to eq('sample body')
      end

      it 'valid user' do
        expect(@new_post.author).to eq(@alice)
      end

      it 'valid user' do
        expect(@new_post.tags).to include(@post.tags.first)
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
