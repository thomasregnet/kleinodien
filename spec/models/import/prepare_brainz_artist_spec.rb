require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PrepareBrainzArtist do
  before(:each) do
    @cache      = Import::Cache.new
    @foreign_id = BrainzArtistId.new(
      value: '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    )
  end

  specify '.perform without cached artist' do
    artist_importer = Import::PrepareBrainzArtist.new(
      cache:      @cache,
      foreign_id: @foreign_id
    )
    artist_importer.using_id
    expect(@cache.any_required?).to be true
  end

  specify '.perform with cached artist' do
    xml = KoTestData.brainz_xml_for(@foreign_id)
    @cache.store_brainz(@foreign_id, xml)
    Import::PrepareBrainzArtist.using_id(
      cache:      @cache,
      foreign_id: @foreign_id
    )
    expect(@cache.any_required?).to be false
  end
end
