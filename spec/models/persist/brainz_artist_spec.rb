require "rails_helper"
require 'ko_test_data'

RSpec.describe Persist::BrainzArtist do
  it 'persists an artist' do
    brainz_id = '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    foreign_id = BrainzArtistId.new(value: brainz_id)
    xml = KoTestData.brainz_xml_for(foreign_id)

    cache = Import::Cache.new
    cache.store_brainz(foreign_id, xml)

    artist = Persist::BrainzArtist.using_id(foreign_id, cache)
    expect(artist.new_record?).to be false
    expect(artist.name).to eq('Jello Biafra')
  end
end
