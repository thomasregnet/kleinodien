require 'rails_helper'
require 'shared_examples_for_brainz_artist_source_id'
require 'shared_examples_for_brainz_references'

RSpec.describe BrainzArtistRef do
  before(:all) do
    @reference = BrainzArtistRef.new(code: uuid)
  end

  def query_string
    '?inc=url-rels'
  end

  def uuid
    '15251e27-d553-492e-ae81-2a6acb0ca8ad'
  end

  it 'returns the ref_key' do
    expected = "artist/#{uuid}#{query_string}"
    expect(@reference.to_key).to eq(expected)
  end

  it_behaves_like 'a MusicBrainz reference' do
    let(:reference)  do
      described_class.new(code: 'ff11eada-b5fa-4b8b-a1bc-17a9cccff1c4')
    end 
  end
end
