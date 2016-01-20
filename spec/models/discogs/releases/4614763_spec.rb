require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe 'Iron Maiden - Killers' do
  before(:all) do
    DatabaseCleaner.start

    json = DiscogsTestHelper.get_discogs_data('release', 4614763)
    dc_release = KleinodienDiscogs.get_release(json)
    @album_release = Discogs::InsertRelease.perform(dc_release)
  end

  it_behaves_like 'an AlbumRelease imported from discogs' do
    let(:album_release)      { @album_release }
    let(:title)              { 'Killers' }
    let(:artist_credit_name) { 'Iron Maiden' }
    let(:country)            { 'Italy' }
    let(:date)               { '1998-01-01' }
    let(:date_mask)          { 4 }
    let(:discogs_id)         { '4614763' }
    let(:discogs_master_id)  { '14360' }
  end

end
