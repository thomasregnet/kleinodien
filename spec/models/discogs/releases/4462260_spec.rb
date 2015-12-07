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

  it "has imported the formats" do
    formats = @album_release.formats

    format = formats[0]
    expect(format.kind.name).to eq('All Media')
    expect(format.quantity).to eq(1)
    expect(format.note).to eq('Hardcover-Artbook')
    expect(format.details[0].kind.name).to eq('Limited Edition')

    format = formats[1]
    expect(format.kind.name).to eq('CD')
    expect(format.quantity).to eq(3)
    expect(format.details[0].kind.name).to eq('Compilation')

    format = formats[2]
    expect(format.kind.name).to eq('CD')
    expect(format.quantity).to eq(1)
    expect(format.details[0].kind.name).to eq('Album')

    format = formats[3]
    expect(format.kind.name).to eq('Vinyl')
    expect(format.quantity).to eq(1)
    expect(format.details[0].kind.name).to eq('12"')
    expect(format.details[1].kind.name).to eq('Picture Disc')
    expect(format.details[2].kind.name).to eq('Album')
  end
  
  it 'has imported the tracks' do
    tracks = @album_release.tracks

    track = tracks[0]
    expect(track.heading).to eq('Cd 1')
    expect(track.release.title).to eq('Shredded Humans')

    track = tracks[20]
    expect(track.heading).to eq('Cd 2')
    expect(track.release.title).to eq('Devoured By Vermin')

    track = tracks[42]
    expect(track.heading).to eq('Cd 3')
    expect(track.release.title).to eq('Decency Defied')

    track = tracks[72]
    expect(track.heading).to eq('Torturing And Eviscerating Live')
    expect(track.release.title).to eq('A Skull Full Of Maggots')

    expect(track.heading).to eq('Torturing And Eviscerating Live')
    expect(track.release.title).to eq('A Skull Full Of Maggots')
  end

  it 'has imported the labels' do

  end

  after(:all) { DatabaseCleaner.clean }
end
