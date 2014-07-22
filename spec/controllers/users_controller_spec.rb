require 'rails_helper'

describe UsersController, type: :controller do

  describe "GET 'edit'" do
    it "returns http success" do
      sign_in FactoryGirl.create(:alice)

      get :edit
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      sign_in FactoryGirl.create(:alice)

      patch :update, user: { nickname: 'bob' }
      response.should redirect_to('/user/edit')
    end
  end

end
