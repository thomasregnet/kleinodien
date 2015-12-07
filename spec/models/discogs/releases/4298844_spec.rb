require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe "Aphrodite's Child - 666 from Discogs" do
  before(:all) do
    DatabaseCleaner.start

    json = DiscogsTestHelper.get_discogs_data('release', 4298844)
    dc_release = KleinodienDiscogs.get_release(json)
    @album_release = Discogs::InsertRelease.perform(dc_release)
  end

  it_behaves_like 'an AlbumRelease imported from discogs' do
    let(:album_release)      { @album_release }
    let(:title)              { '666' }
    let(:artist_credit_name) { "Aphrodite's Child" }
    let(:country)            { 'Germany' }
    let(:date)               { '1972-01-01' }
    let(:date_mask)          { 4 }
    let(:discogs_id)         { '4298844' }
    let(:discogs_master_id)  { '6200' }
  end

  it 'has imported the tracks' do

  end

  it 'has imported the labels' do

  end
  
  after(:all) { DatabaseCleaner.clean }
end
