require 'rails_helper'

RSpec.describe ImportCache, type: :model do
  specify '.fetch_brainz_artist' do
    expect(subject).to respond_to(:fetch_brainz_artist)
  end

  specify '.store_brainz_artist' do
    expect(subject).to respond_to('store_brainz_artist')
  end

  specify '.require_brainz_artist' do
    expect(subject).to respond_to('require_brainz_artist')
  end

  specify 'write and read known' do
    cache = ImportCache.new
    cache.store_discogs_artist('abc', 'foo')
    expect(cache.fetch_discogs_artist('abc')).to eq 'foo'
  end

  specify 'write and read requirements' do
    cache = ImportCache.new
    cache.require_discogs_artist('http://foo/bar', 123)
    # TODO: read the requirements
  end
end
