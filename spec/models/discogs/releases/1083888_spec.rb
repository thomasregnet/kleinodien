require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe 'Jello Biafra With Nomeansno from Discogs' do
  before(:all) do
    DatabaseCleaner.start

    json = DiscogsTestHelper.get_discogs_data('release', 1083888)
    dc_release = KleinodienDiscogs.get_release(json)
    @album_release = Discogs::InsertRelease.perform(dc_release)
  end

  it_behaves_like 'an AlbumRelease imported from discogs' do
    let(:album_release)      { @album_release }
    let(:title)              { 'The Sky Is Falling And I Want My Mommy' }
    let(:artist_credit_name) { 'Jello Biafra With Nomeansno' }
    let(:country)            { 'UK' }
    let(:date)               { '1991-01-01' }
    let(:date_mask)          { 4 }
    let(:discogs_id)         { '1083888' }
    let(:discogs_master_id)  { '32000' }
  end

  it 'has imported the tracks' do

  end

  it 'has imported the labels' do

  end
  
  after(:all) { DatabaseCleaner.clean }
end
