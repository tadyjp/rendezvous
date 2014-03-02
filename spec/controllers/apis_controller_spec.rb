require 'spec_helper'

describe ApisController do

  describe "GET 'markdown_preview'" do
    it "returns http success" do
      get 'markdown_preview'
      response.should be_success
    end
  end

end
