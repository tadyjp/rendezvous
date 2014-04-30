step 'access :site' do |site|
  Capybara.app_host = site
end

step 'visit :path' do |path|
  visit path
end

step 'response code is :code' do |code|
  expect(page.status_code.to_i).to eq(code.to_i)
end

step 'page includes :string' do |string|
  expect(page).to have_content(string)
end

step 'response includes :string' do |string|
  expect(page.body).to include(string)
end

step 'h1 include :string' do |string|
  expect(page.find('h1')).to have_content(string)
end

step 'login' do
  visit '/users/auth/google_oauth2'
end

step 'logout' do
  click_on 'SignOut'
end

step 'create post :title' do |title|
  Post.create title: title
end

step 'search by :query' do |query|
  within("#app-search-form") do
    fill_in 'q', :with => query
  end
  first(:css, "#app-search-form button[type='submit']").click
end

step 'click item' do
  first(:css, '.post-list').click
end

step 'post :title shown' do |title|
  expect(page.find('.panel-title a')).to have_content(title)
end
