require 'spec_helper'

describe WelcomeController, type: :controller do

  describe "GET 'top'" do
    it 'should be successful' do
      get :top
      expect(response).to be_success
      expect(response.code).to eq('200')
    end
  end

  describe 'Login' do

    let(:user) { FactoryGirl.create(:alice) }

    describe "GET 'top'" do

      it 'should be successful' do
        sign_in FactoryGirl.create(:alice)

        get :top
        expect(subject).to redirect_to controller: 'flow',
                                       action: 'show'
      end

      it 'should find the right user' do
        sign_in user

        get :top
        expect(assigns(:current_user)).to eq(user)
      end

    end
  end

end
