require 'rails_helper'
require 'brainz_test_helper'

RSpec.describe Import::BrainzRelease, type: :model do
  before(:each) do
    DatabaseCleaner.start
    @xml = BrainzTestHelper.get_xml(
      :artist,
      'af8e4cc5-ef54-458d-a194-7b210acf638f'
    )
  end

  it 'gets the xml data' do
    #byebug
    expect(@xml).not_to be nil
  end

  it 'returns an Artist' do
    artist = Import::BrainzArtist.perform(@xml)
    expect(artist).to be_instance_of Artist
    # expect(artist.name).to eq 'Cannibal Corpse'
  end

  after(:each) do
    DatabaseCleaner.clean
  end
end
