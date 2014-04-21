require 'spec_helper'

describe SearchController do

  describe "GET 'show' without login" do
    it "returns http redirect" do
      get 'show'
      expect(response).to redirect_to('/')
    end
  end

  describe "GET 'show' with login" do
    login_user

    it "returns http success" do
      get 'show'
      expect(response).to be_success
    end
  end

end
