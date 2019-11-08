require 'config'
require 'store'

feature 'user registration' do
  before(:all) do
    config = Config.new('/Users/jaetimothysalva/projects/chitter/config.json')
    config.init_test_credentials
    Store.init config.test_project_id
  end

  let(:name) { 'Tim' }
  let(:username) { 'jtsalva' }
  let(:email) { 'tim@jtsalva.dev' }
  let(:password) { 'thelegend27' }

  scenario 'user registers' do
    visit '/register'
    fill_in 'name', with: name
    fill_in 'username', with: username
    fill_in 'email', with: email
    fill_in 'password', with: password

    click_button 'submit'

    expect(page).to have_content username
  end
end