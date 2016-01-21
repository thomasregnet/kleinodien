# coding: utf-8
require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe 'Various ‎– Judgment Night - Music From The Motion Picture' do
  before(:all) do
    DatabaseCleaner.start

    json = DiscogsTestHelper.get_discogs_data('release', 612384)
    dc_release = KleinodienDiscogs.get_release(json)
    @album_release = Discogs::InsertRelease.perform(dc_release)
  end

  it_behaves_like 'an AlbumRelease imported from discogs' do
    let(:album_release)      { @album_release }
    let(:title)             { 'Judgment Night - Music From The Motion Picture' }
    let(:artist_credit_name) { 'Various ,' } # aargh a comma!
    let(:country)            { 'Europe' }
    let(:date)               { '1993-01-01' }
    let(:date_mask)          { 4 }
    let(:discogs_id)         { '612384' }
    let(:discogs_master_id)  { '17610' }
  end

  after(:all) { DatabaseCleaner.clean }
end
