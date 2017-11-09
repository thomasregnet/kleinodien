require 'rails_helper'
require 'shared_examples_for_brainz_artist_source_id'

RSpec.describe BrainzArtistRef do
  before(:all) do
    @foreign_id = BrainzArtistRef.new(code: uuid)
  end

  def query_string
    '?inc=url-rels'
  end

  def uuid
    '15251e27-d553-492e-ae81-2a6acb0ca8ad'
  end

  it 'returns the ref_key' do
    expected = "artist/#{uuid}#{query_string}"
    expect(@foreign_id.to_key).to eq(expected)
  end
end
