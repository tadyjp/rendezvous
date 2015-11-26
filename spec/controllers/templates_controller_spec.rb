require 'rails_helper'

RSpec.describe TemplatesController, type: :controller do
  describe "GET 'show' without template" do
    it 'returns http success' do
      sign_in FactoryGirl.create(:alice)

      get 'show'
      expect(response).to be_success
    end
  end

  describe "GET 'show' with template" do
    it 'returns http success' do
      sign_in FactoryGirl.create(:alice)

      get 'show'
      expect(response).to be_success
    end
  end
end
