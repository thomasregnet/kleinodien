require "rails_helper"
require 'ko_test_data'

RSpec.describe ImportBrainzArtist do
  before(:each) do
    @jello_biafra_id = '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
  end

  specify '.perform without cached artist' do
    artist_importer = ImportBrainzArtist.new(@jello_biafra_id, ImportCache.new)
    artist_importer.perform
    expect(artist_importer.cache.any_required?).to be true
  end

  specify '.perform with cached artist' do
    artist_sid = BrainzArtistId.new(@jello_biafra_id)
    xml = KoTestData.brainz_artist(artist_sid)
    cache = ImportCache.new
    cache.store_brainz(artist_sid.source_id, xml)
    artist = ImportBrainzArtist.perform(@jello_biafra_id, cache)
    expect(artist).to be_instance_of(Artist)
    expect(artist.new_record?).to be false
  end
end
