require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Request via js', js: true do

  let(:user) { FactoryGirl.create(:login_user_1) }

  before do
    @post1 = Post.create title: 'ruby rspec', body: 'This is first espec test: ruby', author_id: user.id, updated_at: Time.new(2014, 1, 1, 12, 0, 0)
    @post2 = Post.create title: 'php test', body: 'PHP is very easy', author_id: user.id, updated_at: Time.new(2014, 1, 1, 13, 0, 0)
    @post3 = Post.create title: 'java java...', body: 'Java is not ruby...', author_id: user.id, updated_at: Time.new(2014, 1, 1, 14, 0, 0)
  end

  before :each do
    login_as user, scope: :user
    visit '/flow'
  end

  it 'show first post' do
    page.save_screenshot(Rails.root.join('tmp', 'screenshots', "a-#{Time.now.strftime('%Y-%m-%d %H%M%S')}.png"))
    expect(page.find('.post-list:first-child h4').text).to include('java java')
  end

  after :each do
    page.driver.reset!
    Warden.test_reset!
  end

end
