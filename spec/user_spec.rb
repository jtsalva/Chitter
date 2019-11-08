require 'user'

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
end