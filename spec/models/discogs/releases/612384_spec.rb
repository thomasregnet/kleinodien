# coding: utf-8

require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe 'Various ‎– Judgment Night - Music From The Motion Picture' do
  before(:all) do
    DatabaseCleaner.start
    @album_release = DiscogsTestHelper.insert_release(612_384)
  end

  it_behaves_like 'an AlbumRelease imported from discogs' do
    let(:title) { 'Judgment Night - Music From The Motion Picture' }
    let(:album_release)      { @album_release }
    let(:artist_credit_name) { 'Various' }
    let(:country)            { 'Europe' }
    let(:date)               { '1993-01-01' }
    let(:date_mask)          { 4 }
    let(:discogs_id)         { '612384' }
    let(:discogs_master_id)  { '17610' }
  end

  after(:all) { DatabaseCleaner.clean }
end
