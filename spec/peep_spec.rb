require 'peep'

describe Peep do
  subject { Peep.new(text: text, author: author, created_at: created_at) }
  let(:text) { 'lol' }
  let(:author) { 'jtsalva' }
  let(:created_at) { 'utc_timestamp' }

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
end