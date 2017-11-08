require 'rails_helper'
require 'shared_examples_for_brainz_artist_source_id'

RSpec.describe BrainzArtistRef do
  before(:all) do
    @foreign_id = BrainzArtistRef.new(value: uuid)
  end

  def uuid
    '15251e27-d553-492e-ae81-2a6acb0ca8ad'
  end

  def query_string
    '?inc=url-rels'
  end

  describe '.source_id' do
    it_behaves_like 'a brainz artist source id' do
      let(:source_id) { BrainzArtistRef.source_id(SecureRandom.uuid) }
    end
  end

  describe '#source_id' do
    it_behaves_like 'a brainz artist source id' do
      brainz_artist_id = BrainzArtistRef.new(value: SecureRandom.uuid)
      let(:source_id) { brainz_artist_id.source_id }
    end
  end

  it 'returns the cache_key' do
    expected = "artist/#{uuid}#{query_string}"
    expect(@foreign_id.cache_key).to eq(expected)
  end
end
