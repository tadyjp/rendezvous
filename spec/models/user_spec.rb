# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  image_url               :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  google_auth_token       :string(255)
#  google_refresh_token    :string(255)
#  google_token_expires_at :datetime
#  nickname                :string(255)      default(""), not null
#

require 'rails_helper'

describe User do
  describe 'Instance method' do
    let(:bob) { create(:bob) }
    let(:alice) { create(:alice) }
    let(:post) { create(:post) }

    describe '#google_oauth_token_expired?' do
      it 'not expired' do
        expect(alice.google_oauth_token_expired?).to be_falsey
      end

      it 'expired' do
        expect(bob.google_oauth_token_expired?).to be_truthy
      end
    end

    describe '#unwatch / #watch / #watching?' do
      it 'not watching' do
        expect(alice.watching?(post: post)).to be_falsey
      end

      it '#watch!' do
        alice.watch!(post: post)
        expect(alice.watching?(post: post)).to be_truthy
      end

      it '#watch! (uniqueness)' do
        alice.watch!(post: post)
        alice.watch!(post: post)
        expect(alice.watching_posts.size).to be(1)
      end

      it '#unwatch!' do
        alice.watch!(post: post)
        alice.unwatch!(post: post)
        expect(alice.watching?(post: post)).to be_falsey
      end
    end
  end

  describe 'validation' do
    before(:each) do
      @attr = {
        name: 'Example User',
        email: 'user@example.com',
        nickname: 'testnick',
        password: 'changeme',
        password_confirmation: 'changeme'
      }
    end

    it 'should create a new instance given a valid attribute' do
      User.create!(@attr)
    end

    it 'should require an email address' do
      no_email_user = User.new(@attr.merge(email: ''))
      expect(no_email_user).not_to be_valid
    end

    it 'should accept valid email addresses' do
      addresses = %w(user@foo.com THE_USER@foo.bar.org first.last@foo.jp)
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(email: address))
        expect(valid_email_user).to be_valid
      end
    end

    it 'should reject invalid email addresses' do
      addresses = %w(user@foo,com user_at_foo.org example.user@foo.)
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(email: address))
        expect(invalid_email_user).not_to be_valid
      end
    end

    it 'should reject duplicate email addresses' do
      User.create!(@attr)
      user_with_duplicate_email = User.new(@attr)
      expect(user_with_duplicate_email).not_to be_valid
    end

    it 'should reject email addresses identical up to case' do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(email: upcased_email))
      user_with_duplicate_email = User.new(@attr)
      expect(user_with_duplicate_email).not_to be_valid
    end

    describe 'passwords' do
      before(:each) do
        @user = User.new(@attr)
      end

      it 'should have a password attribute' do
        expect(@user).to respond_to(:password)
      end

      it 'should have a password confirmation attribute' do
        expect(@user).to respond_to(:password_confirmation)
      end
    end

    describe 'password validations' do
      it 'should require a password' do
        expect(User.new(@attr.merge(password: '', password_confirmation: ''))).not_to be_valid
      end

      it 'should require a matching password confirmation' do
        expect(User.new(@attr.merge(password_confirmation: 'invalid'))).not_to be_valid
      end

      it 'should reject short passwords' do
        short = 'a' * 5
        hash = @attr.merge(password: short, password_confirmation: short)
        expect(User.new(hash)).not_to be_valid
      end
    end

    describe 'password encryption' do
      before(:each) do
        @user = User.create!(@attr)
      end

      it 'should have an encrypted password attribute' do
        expect(@user).to respond_to(:encrypted_password)
      end

      it 'should set the encrypted password attribute' do
        expect(@user.encrypted_password).not_to be_blank
      end
    end
  end

  describe 'draft' do
    pending 'draft'
  end
end
