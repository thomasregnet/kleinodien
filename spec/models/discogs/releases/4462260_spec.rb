require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe 'Cannibal Corpse - Dead Human Collectio from Discogs' do
  before(:all) do
    DatabaseCleaner.start
    @album_release = DiscogsTestHelper.insert_release(4_462_260)
  end

  it_behaves_like 'an AlbumRelease imported from discogs' do
    let(:album_release) { @album_release }
    let(:title) { 'Dead Human Collection: 25 Years Of Death Metal' }
    let(:artist_credit_name) { 'Cannibal Corpse' }
    let(:country)            { 'Europe' }
    let(:date)               { '2013-03-29' }
    let(:date_mask)          { 7 }
    let(:discogs_id)         { '4462260' }
    let(:discogs_master_id)  { '543219' }
  end

  it 'has imported the formats' do
    formats = @album_release.formats

    format = formats[0]
    expect(format.format.name).to eq('All Media')
    expect(format.quantity).to eq(1)
    expect(format.note).to eq('Hardcover-Artbook')
    expect(format.details[0].detail.name).to eq('Limited Edition')

    format = formats[1]
    expect(format.format.name).to eq('CD')
    expect(format.quantity).to eq(3)
    expect(format.details[0].detail.name).to eq('Compilation')

    format = formats[2]
    expect(format.format.name).to eq('CD')
    expect(format.quantity).to eq(1)
    expect(format.details[0].detail.name).to eq('Album')

    format = formats[3]
    expect(format.format.name).to eq('Vinyl')
    expect(format.quantity).to eq(1)
    expect(format.details[0].detail.name).to eq('12"')
    expect(format.details[1].detail.name).to eq('Picture Disc')
    expect(format.details[2].detail.name).to eq('Album')
  end

  it 'has imported the tracks' do
    tracks = @album_release.tracks

    track = tracks[0]
    expect(track.heading).to eq('Cd 1')
    expect(track.piece_release.title).to eq('Shredded Humans')

    track = tracks[3]
    expect(track.duration.mmss).to   eq '2:04'
    expect(track.duration.hhmmss).to eq '0:02:04'

    track = tracks[20]
    expect(track.heading).to eq('Cd 2')
    expect(track.piece_release.title).to eq('Devoured By Vermin')

    track = tracks[42]
    expect(track.heading).to eq('Cd 3')
    expect(track.piece_release.title).to eq('Decency Defied')

    track = tracks[72]
    expect(track.heading).to eq('Torturing And Eviscerating Live')
    expect(track.piece_release.title).to eq('A Skull Full Of Maggots')

    expect(track.heading).to eq('Torturing And Eviscerating Live')
    expect(track.piece_release.title).to eq('A Skull Full Of Maggots')
  end

  it 'has imported the labels' do
    label = @album_release.labels[0]
    expect(label.company.name).to eq('Metal Blade Records GmbH')
    expect(label.catalog_no).to eq('3984-15180-0')
  end

  after(:all) { DatabaseCleaner.clean }
end
