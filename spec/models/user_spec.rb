require 'spec_helper'

describe User do
  before :each do
    @alice = create(:alice)
    @bob = create(:bob)
  end

  describe '#google_oauth_token_expired?' do

    it 'not expired' do
      expect(@alice.google_oauth_token_expired?).to be_false
    end

    it 'expired' do
      expect(@bob.google_oauth_token_expired?).to be_true
    end

  end
end
