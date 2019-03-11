require 'rails_helper'

describe StockController, type: :controller do
  describe "GET 'show' without login" do
    it 'returns http redirect' do
      get 'show'
      expect(response).to redirect_to('/')
    end
  end

  describe "GET 'show' with login" do
    it 'returns http success' do
      sign_in FactoryGirl.create(:alice)

      get 'show'
      expect(response).to be_success
    end
  end
end
