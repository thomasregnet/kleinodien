require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PersistBrainzCompilationHead do
  before(:each) do
    @cache = Import::Cache.new
    brainz_id = '7d31891f-b9da-36de-ab08-98b1fdbbb023'
    @foreign_id = BrainzReleaseGroupId.new(value: brainz_id)
    KoTestData.store_brainz_cache(@foreign_id, @cache)

    jello_id = '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
    KoTestData.store_brainz_cache(BrainzArtistId.new(value: jello_id), @cache)

    nomeansno_id = '37e9d7b2-7779-41b2-b2eb-3685351caad3'
    KoTestData.store_brainz_cache(
      BrainzArtistId.new(value: nomeansno_id),
      @cache
    )
  end

  it 'persists a brainz release-group' do
    artist_credit = FactoryGirl.create(:artist_credit)
    compilation_head = Import::PersistBrainzCompilationHead.using_id(
      @foreign_id, @cache
    )
    expect(compilation_head.new_record?).to be false
  end
end
