require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PrepareBrainzArtist do
  before(:each) do
    @cache      = Import::Cache.new
    @reference = BrainzArtistRef.new(
      code: '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    )
  end

  specify '.perform without cached artist' do
    artist_importer = Import::PrepareBrainzArtist.new(
      cache:      @cache,
      reference: @reference
    )
    artist_importer.perform
    expect(@cache.any_required?).to be true
  end

  specify '.perform with cached artist' do
    xml = KoTestData.brainz_xml_for(@reference)
    @cache.store_brainz(@reference, xml)
    Import::PrepareBrainzArtist.perform(
      cache:      @cache,
      reference: @reference
    )
    expect(@cache.any_required?).to be false
  end
end
