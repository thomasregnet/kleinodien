require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe 'Cannibal Corpse - Dead Human Collectio from Discogs' do
  before(:all) do
    DatabaseCleaner.start

    json = DiscogsTestHelper.get_discogs_data('release', 4462260)
    dc_release = KleinodienDiscogs.get_release(json)
    @album_release = Discogs::InsertRelease.perform(dc_release)
  end

  it_behaves_like 'an AlbumRelease imported from discogs' do
    let(:album_release)      { @album_release }
    let(:title)            { 'Dead Human Collection: 25 Years Of Death Metal' }
    let(:artist_credit_name) { 'Cannibal Corpse' }
    let(:country)            { 'Europe' }
    let(:date)               { '2013-03-29' }
    let(:date_mask)          { 7 }
    let(:discogs_id)         { '4462260' }
    let(:discogs_master_id)  { '543219' }
  end

  it 'has imported the tracks' do

  end

  it 'has imported the labels' do

  end

  after(:all) { DatabaseCleaner.clean }
end
