require 'rails_helper'
require 'brainz_test_helper'

RSpec.describe Import::BrainzRelease, type: :model do
  before(:each) do
    @brainz_id = 'af8e4cc5-ef54-458d-a194-7b210acf638f'
    @xml = BrainzTestHelper.get_xml(:artist, @brainz_id)
    @artist = Import::BrainzArtist.perform(@xml)
  end

  it 'returns the expected Artist' do
    expect(@artist).to be_instance_of Artist
    expect(@artist.name).to eq 'Cannibal Corpse'
    identifier_values = @artist.identifiers.map(&:value)
    expect(identifier_values).to include @brainz_id
    expect(identifier_values).to include '124774' # Discogs id
  end
end
