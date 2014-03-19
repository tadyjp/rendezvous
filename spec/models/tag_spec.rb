require 'spec_helper'

describe Tag do
  describe '#move_all_posts_to!' do
    before :each do
      @tag_ruby = Tag.create(name: 'ruby')
      @tag_java = Tag.create(name: 'java')
      @post1 = Post.create id: 1001, title: 'ruby rspec', body: 'hoge', tags: [@tag_ruby]
      @post2 = Post.create id: 1002, title: 'ruby is better than java', body: 'hoge', tags: [@tag_ruby, @tag_java]
      @post3 = Post.create id: 1003, title: 'java java...', body: 'hoge', tags: [@tag_java]
    end

    it 'successfully moved' do
      expect(Tag.find_by(name: 'ruby').posts).to have(2).items
      expect(Tag.find_by(name: 'java').posts).to have(2).items
      @tag_java.move_all_posts_to!(@tag_ruby)
      expect(Tag.find_by(name: 'ruby').posts).to have(3).items
      expect(Tag.find_by(name: 'java').posts).to have(0).items
    end
  end

  describe '#set_parent!' do
    before :each do
      @tag_ruby = Tag.create(name: 'ruby')
      @tag_lang = Tag.create(name: 'lang')
    end

    it 'successfully moved' do
      expect(@tag_ruby.parent).not_to eq(@tag_lang)
      expect(@tag_lang.children).not_to include(@tag_ruby)
      @tag_ruby.set_parent!(@tag_lang)
      expect(@tag_ruby.parent).to eq(@tag_lang)
      expect(@tag_lang.children).to include(@tag_ruby)
    end
  end
end
