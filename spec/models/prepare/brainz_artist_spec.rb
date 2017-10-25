require 'rails_helper'
require 'ko_test_data'

RSpec.describe Prepare::BrainzArtist do
  before(:each) do
    @cache      = Import::Cache.new
    @foreign_id = BrainzArtistId.new(
      value: '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    )
  end

  specify '.perform without cached artist' do
    artist_importer = Prepare::BrainzArtist.new(@foreign_id, @cache)
    artist_importer.using_id
    expect(@cache.any_required?).to be true
  end

  specify '.perform with cached artist' do
    xml = KoTestData.brainz_xml_for(@foreign_id)
    @cache.store_brainz(@foreign_id, xml)
    Prepare::BrainzArtist.using_id(@foreign_id, @cache)
    expect(@cache.any_required?).to be false
  end
end
