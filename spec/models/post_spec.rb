require 'spec_helper'

describe Post do

  describe 'Instance method' do
    before :each do
      @post = create(:post)
      @alice = create(:alice)
    end

    describe 'Fork' do

      subject { @post.generate_fork(user: @alice) }

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

end
