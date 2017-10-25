require 'rails_helper'

# Mock an id-class for testing
class MockForeignId
  def cache_key
    'mocke/cache?key'
  end
end

RSpec.describe Import::Cache, type: :model do
  before(:each) do
    @cache   = Import::Cache.new
    @mocked_foreign_id = MockForeignId.new
  end

  specify '#fetch_brainz' do
    expect(subject).to respond_to(:fetch_brainz)
  end

  specify '#store_brainz' do
    expect(subject).to respond_to(:store_brainz)
  end

  specify '#require_brainz' do
    expect(subject).to respond_to(:require_brainz)
  end

  specify 'write and read known' do
    @cache.store_discogs(@mocked_foreign_id, 'foo')
    expect(@cache.fetch_discogs(@mocked_foreign_id)).to eq 'foo'
  end

  specify 'write and read requirements' do
    cache = Import::Cache.new
    cache.require_discogs(@mocked_foreign_id)
    expect(cache.required['discogs'][0]).to eq(@mocked_foreign_id.cache_key)
  end

  it 'stores only one unique uri for a requirement' do
    #cache = Import::Cache.new
    uri   = 'http://some/fake/url'

    3.times do
      #@cache.require_tmdb(uri)
      @cache.require_tmdb(@mocked_foreign_id)
    end

    expect(@cache.required['tmdb'].length).to eq(1)
  end

  it '#fetch_<source_name>! raises Import::CacheMissingEntry on missing data' do
    expect { @cache.fetch_brainz!(@mocked_foreign_id) }
      .to raise_error(Import::CacheMissingEntry)
  end
end
