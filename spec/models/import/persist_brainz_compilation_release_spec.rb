require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PersistBrainzCompilationRelease do
  before(:each) do
    @cache = Import::Cache.new
    @brainz_id = '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
    @reference = BrainzReleaseRef.new(code: @brainz_id)
  end

  it 'persists a MusicBrainz release' do
    KoTestData.store_brainz_cache(@reference, @cache)
    KoTestData.store_brainz_cache(
      BrainzArtistRef.new(code: '1d93c839-22e7-4f76-ad84-d27039efc048'),
      @cache
    )
    KoTestData.store_brainz_cache(
      BrainzReleaseGroupRef.new(code: '5fc9ba9d-bc39-38fc-a479-eadbf0f3a933'),
      @cache
    )
    compilation_release = Import::PersistBrainzCompilationRelease.perform(
      reference: @reference,
      cache:      @cache
    )
    expect(compilation_release.title).to eq('Arise')
  end

  it 'raises when data is missing' do
    expect do
      Import::PersistBrainzCompilationRelease.perform(
        reference: @reference,
        cache: @cache
      )
    end.to raise_error(Import::CacheMissingEntry)
  end
end
