require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PersistBrainzArtist do
  before(:each) do
    @cache      = Import::Cache.new
    @brainz_id  = '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    @foreign_id = BrainzArtistId.new(value: @brainz_id)
  end
  it 'persists an artist' do
    xml = KoTestData.brainz_xml_for(@foreign_id)

    @cache.store_brainz(@foreign_id, xml)

    artist = Import::PersistBrainzArtist.using_id(@foreign_id, @cache)
    expect(artist.new_record?).to be false
    expect(artist.name).to eq('Jello Biafra')
  end

  it 'raises when .using_id is called without having data cached' do
    expect { Import::PersistBrainzArtist.using_id(@foreign_id, @cache) }
      .to raise_error(Import::CacheMissingEntry)
  end
end
