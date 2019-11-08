require 'peep'
require 'config'
require 'store'

describe Peep do
  before(:all) do
    config = Config.new('/Users/jaetimothysalva/projects/chitter/config.json')
    config.init_test_credentials
    Store.init config.test_project_id
  end

  subject { Peep.new(text: text, author: author, created_at: created_at) }
  let(:text) { 'lol' }
  let(:author) { 'jtsalva' }
  let(:created_at) { Store.timestamp }

  describe 'properties' do
    it 'has text' do
      expect(subject.text).to eq text
    end

    it 'has an author' do
      expect(subject.author).to eq author
    end

    it 'records timestamp of creation' do
      expect(subject.created_at).to eq created_at
    end
  end

  describe 'database actions' do
    before(:each) do
      Peep.clear
    end

    it 'starts with an empty collection' do
      expect(Peep.all.length).to eq 0
    end

    it 'can add peeps' do
      id = Peep.add(subject)
      expect(Peep.get(id)).to have_attributes(
        text: subject.text,
        author: subject.author
      )
    end

    it 'can update peeps' do
      id = Peep.add(subject)
      updated_peep = Peep.new(
       text: 'updated text',
       author: subject.author,
       id: id
      )
      Peep.update(updated_peep)

      expect(Peep.get(id)).to have_attributes(
        text: updated_peep.text,
        author: updated_peep.author
      )
    end

    it 'can delete peeps' do
      id = Peep.add(subject)
      Peep.delete(subject)
      expect(Peep.get(id)).to eq nil
    end
  end
end