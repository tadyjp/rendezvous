require 'rails_helper'

describe PostsController, type: :controller do

  let(:post) { FactoryGirl.create(:post) }

  describe "GET 'show' without login" do
    it 'returns http redirect' do
      get 'show', id: post.id
      expect(response).to redirect_to('/')
    end
  end

  describe "GET 'show' with login" do

    let(:alice) { FactoryGirl.create(:alice) }

    it 'returns http success' do
      sign_in FactoryGirl.create(:alice)

      get 'show', id: post.id
      expect(response).to be_success
    end

    it 'returns http success' do
      sign_in alice

      get 'show', id: post.id
      expect(Footprint.where(user_id: alice.id, post_id: post.id)).to exist
    end
  end

end
