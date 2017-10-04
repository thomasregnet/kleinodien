require 'rails_helper'

RSpec.describe ImportCache, type: :model do
  specify '.fetch_brainz_artist' do
    expect(subject).to respond_to(:fetch_brainz)
  end

  specify '.store_brainz_artist' do
    expect(subject).to respond_to(:store_brainz)
  end

  specify '.require_brainz_artist' do
    expect(subject).to respond_to(:require_brainz)
  end

  specify 'write and read known' do
    cache = ImportCache.new
    cache.store_discogs('abc', 'foo')
    expect(cache.fetch_discogs('abc')).to eq 'foo'
  end

  specify 'write and read requirements' do
    cache = ImportCache.new
    cache.require_discogs('http://foo/bar')
    expect(cache.required['discogs'][0]).to eq 'http://foo/bar'
  end

  it 'stores only one unique uri for a requirement' do
    cache = ImportCache.new
    uri   = 'http://some/fake/url'

    3.times do
      cache.require_tmdb(uri)
    end

    expect(cache.required['tmdb'].length).to eq(1)
  end
end
