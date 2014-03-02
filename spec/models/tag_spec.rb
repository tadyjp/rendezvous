require 'spec_helper'

describe Tag do
  describe '#move_posts_to' do
    before :each do
      @tag_ruby = Tag.create(name: 'ruby')
      @tag_java = Tag.create(name: 'java')
      @post1 = Post.create id: 1001, title: 'ruby rspec', tags: [@tag_ruby]
      @post2 = Post.create id: 1002, title: 'ruby is better than java', tags: [@tag_ruby, @tag_java]
      @post3 = Post.create id: 1003, title: 'java java...', tags: [@tag_java]
    end

    it 'successfully moved' do
      expect(Tag.find_by(name: 'ruby').posts).to have(2).items
      expect(Tag.find_by(name: 'java').posts).to have(2).items
      @tag_java.move_all_posts_to!(@tag_ruby)
      expect(Tag.find_by(name: 'ruby').posts).to have(3).items
      expect(Tag.find_by(name: 'java').posts).to have(0).items
    end
  end
end
