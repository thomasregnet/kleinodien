require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PersistBrainzArtistCredit do
  # TODO: Specs for #find_by
  # TODO: Specs for #create
  before(:each) do
    @cache = Import::Cache.new
    foreign_id = BrainzReleaseRef.new(
      code: '693748be-7c18-39c3-af2e-2e62092090cf'
    )
    xml = KoTestData.brainz_xml_for(foreign_id)
    release = MashedBrainz::Release.xml(xml)
    @brainz_artist_credit = release.artist_credit
  end

  it 'persists an artist_credit' do
    %w[2280ca0e-6968-4349-8c36-cb0cbd6ee95f
       37e9d7b2-7779-41b2-b2eb-3685351caad3].each do |brainz_id|
      foreign_id = BrainzArtistRef.new(code: brainz_id)
      xml = KoTestData.brainz_xml_for(foreign_id)
      @cache.store_brainz(foreign_id, xml)
    end
    artist_credit = Import::PersistBrainzArtistCredit.perform(
      template: @brainz_artist_credit,
      cache:    @cache
    )
    expect(artist_credit.new_record?).to be false
    expect(artist_credit.name).to eq('Jello Biafra With NoMeansNo')
  end
end
