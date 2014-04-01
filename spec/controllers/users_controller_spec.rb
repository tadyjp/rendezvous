require 'spec_helper'

describe UsersController do

  before do
  end

  describe "GET 'edit'" do
    login_user
    it "returns http success" do
      get :edit
      response.should be_success
    end
  end

  describe "GET 'update'" do
    login_user
    it "returns http success" do
      patch :update, user: { nickname: 'bob' }
      response.should redirect_to('/user/edit')
    end
  end

end
