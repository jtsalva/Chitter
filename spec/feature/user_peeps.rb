require 'config'
require 'store'
require 'user'

feature 'user can peep' do
  before(:all) do
    config = Config.new('/Users/jaetimothysalva/projects/chitter/config.json')
    config.init_test_credentials
    Store.init config.test_project_id
  end

  let(:name) { 'Tim' }
  let(:username) { 'jtsalva' }
  let(:email) { 'tim@jtsalva.dev' }
  let(:password) { 'thelegend27' }

  scenario 'user peeps' do
    new_user = User.new(username: username, name: name, email: email)
    User.add(new_user)
    User.set_password(new_user, password)

    visit '/sign-in'
    fill_in 'username', with: username
    fill_in 'password', with: password

    click_button 'submit'

    peep_text = 'Big bad peep'
    fill_in 'text', with: peep_text
    click_button 'submit'

    expect(page).to have_content peep_text
  end
end