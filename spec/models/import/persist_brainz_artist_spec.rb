require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PersistBrainzArtist do
  before(:each) do
    @cache      = Import::Cache.new
    @reference  = '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    @reference = BrainzArtistRef.new(code: @reference)
  end
  it 'persists an artist' do
    xml = KoTestData.brainz_xml_for(@reference)

    @cache.store_brainz(@reference, xml)

    artist = Import::PersistBrainzArtist.perform(
      reference: @reference,
      cache:      @cache
    )
    expect(artist.new_record?).to be false
    expect(artist.name).to eq('Jello Biafra')
  end

  it 'raises when .perform is called without having data cached' do
    expect do
      Import::PersistBrainzArtist.perform(
        reference: @reference,
        cache:      @cache
      )
    end.to raise_error(Import::CacheMissingEntry)
  end
end
