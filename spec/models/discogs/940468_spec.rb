require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe 'AC/DC - Highway To Hell, imported from Discogs' do
  before(:all) do
    DatabaseCleaner.start

    json = DiscogsTestHelper.get_discogs_data('release', 940468)
    dc_release = KleinodienDiscogs.get_release(json)
    @albume_release = Discogs::InsertRelease.perform(dc_release)
  end

  it_behaves_like 'an AlbumRelease imported from discogs' do
    let(:album_release)      { @albume_release }
    let(:title)              { 'Highway To Hell' }
    let(:artist_credit_name) { 'AC/DC' }
    let(:country)            { 'Germany' }
    let(:date)               { '2000-11-20' }
    let(:date_mask)          { 7 }
    let(:discogs_id)         { '940468' }
    let(:discogs_master_id)  { '8522' }
  end
  
  after(:all) { DatabaseCleaner.clean }
end
