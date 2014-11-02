require 'rails_helper'

describe TagsController, type: :controller do

  let(:tag) { FactoryGirl.create(:tag_ruby) }

  describe "GET 'show' without login" do
    it 'returns http redirect' do
      get 'show', name: tag.name
      expect(response).to redirect_to('/')
    end
  end

  describe "GET 'show' with login" do
    it 'returns http success' do
      sign_in FactoryGirl.create(:alice)

      get 'show', name: tag.name
      expect(response).to be_success
    end
  end

end
