require 'spec_helper'

describe TagsController do

  let(:tag) { FactoryGirl.create(:tag_ruby) }

  describe "GET 'show' without login" do
    it "returns http redirect" do
      get 'show', name: tag.name
      expect(response).to redirect_to('/')
    end
  end

  describe "GET 'show' with login" do
    login_user

    it "returns http success" do
      get 'show', name: tag.name
      expect(response).to be_success
    end
  end

end
