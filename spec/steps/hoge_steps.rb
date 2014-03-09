step 'access :site' do |site|
  Capybara.app_host = site
end

step 'visit :path' do |path|
  visit path
end

step 'response code is :code' do |code|
  expect(page.status_code.to_i).to eq(code.to_i)
end

step 'response include :string' do |string|
  expect(page).to have_content(string)
end

step 'h1 include :string' do |string|
  expect(page.find('h1')).to have_content(string)
end
