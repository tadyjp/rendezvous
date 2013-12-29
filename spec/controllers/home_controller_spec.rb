require 'spec_helper'

describe HomeController do

  describe "GET 'top'" do
    it "should be successful" do
        get :top
        expect(response).to be_success
        expect(response.code).to eq("200")
    end
  end

  describe 'Login' do

    before (:each) do
      @user = FactoryGirl.create(:login_user_1)
      sign_in @user
    end

    describe "GET 'top'" do

      it "should be successful" do
        get :top
        expect(subject).to redirect_to controller: 'posts',
                                        action: 'index'
      end

      it "should find the right user" do
        get :top
        expect(assigns(:current_user)).to eq(@user)
      end

    end
  end

end
