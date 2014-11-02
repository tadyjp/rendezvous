require 'rails_helper'

describe ApisController, type: :controller do

  describe "GET 'markdown_preview'" do
    it 'returns http redirect' do
      get 'markdown_preview'
      expect(response).to redirect_to('/')
    end
  end

  describe "GET 'markdown_preview'" do
    it 'returns http success' do
      sign_in FactoryGirl.create(:alice)

      get 'markdown_preview'
      expect(response).to be_success
    end
  end

end
