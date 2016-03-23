require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe 'AC/DC - Highway To Hell, imported from Discogs' do
  before(:all) do
    DatabaseCleaner.start

    json = DiscogsTestHelper.get_discogs_data('release', 940_468)
    dc_release = KleinodienDiscogs.get_release(json)
    @album_release = Discogs::InsertRelease.perform(dc_release)
  end

  it_behaves_like 'an AlbumRelease imported from discogs' do
    let(:album_release)      { @album_release }
    let(:title)              { 'Highway To Hell' }
    let(:artist_credit_name) { 'AC/DC' }
    let(:country)            { 'Germany' }
    let(:date)               { '2000-11-20' }
    let(:date_mask)          { 7 }
    let(:discogs_id)         { '940468' }
    let(:discogs_master_id)  { '8522' }
  end

  it 'has imported the tracks' do
    tracks = @album_release.tracks
    expect(tracks.length).to eq(10)

    track = tracks[0]
    expect(track.release.title).to eq('Highway To Hell')
    expect(track.position).to eq('1')

    track = tracks[4]
    expect(track.release.title).to eq('Beating Around The Bush')
    expect(track.position).to eq('5')

    track = tracks[9]
    expect(track.release.title).to eq('Night Prowler')
    expect(track.position).to eq('10')
  end

  it 'has imported the labels' do
    labels = @album_release.labels
    expect(labels.length).to eq(1)

    label = labels[0]
    expect(label.company.name).to eq('Atlantic')
    expect(label.catalog_no).to eq('7567-92419-5')
  end

  after(:all) { DatabaseCleaner.clean }
end
