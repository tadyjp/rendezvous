require 'spec_helper'

describe FlowController do

  before :each do
    @post = create(:post)
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      puts '+++++++++++++++++++++++++++++'
      p response.body
      puts '+++++++++++++++++++++++++++++'
      response.should be_success
    end
  end

end
