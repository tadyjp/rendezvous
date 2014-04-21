require 'spec_helper'

describe ApisController do

  describe "GET 'markdown_preview'" do
    it "returns http redirect" do
      get 'markdown_preview'
      expect(response).to redirect_to('/')
    end
  end

  describe "GET 'markdown_preview'" do
    login_user

    it "returns http success" do
      get 'markdown_preview'
      expect(response).to be_success
    end
  end

end
