require 'user'
require 'config'
require 'store'

describe User do
  subject { User.new(username: username, name: name, email: email) }
  let(:username) { 'jtsalva' }
  let(:name) { 'Tim' }
  let(:email) { 'tim@jtsalva.dev' }

  describe 'properties' do
    it 'has a username' do
      expect(subject.username).to eq username
    end

    it 'has a name' do
      expect(subject.name).to eq name
    end

    it 'has an email' do
      expect(subject.email).to eq email
    end
  end

  describe 'database actions' do
    before(:all) do
      config = Config.new('/Users/jaetimothysalva/projects/chitter/config.json')
      config.init_test_credentials
      Store.init config.test_project_id
    end

    before(:each) do
      User.clear
    end

    it 'starts with an empty collection' do
      expect(User.all.length).to eq 0
    end

    it 'can add users' do
      User.add(subject)
      expect(User.get(subject.username)).to have_attributes(
        username: subject.username,
        name: subject.name,
        email: subject.email
      )
    end

    it 'can update users' do
      User.add(subject)
      updated_user = User.new(
        username: subject.username,
        name: 'updated name',
        email: subject.email
      )
      User.update(updated_user)

      expect(User.get(subject.username)).to have_attributes(
        username: updated_user.username,
        name: updated_user.name,
        email: updated_user.email
      )
    end

    it 'can delete users' do
      User.add(subject)
      User.delete(subject)
      expect(User.get(subject.username)).to eq nil
    end
  end
end