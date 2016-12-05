# coding: utf-8
require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe "Aphrodite's Child - 666 from Discogs" do
  before(:all) do
    DatabaseCleaner.start
    @album_release = DiscogsTestHelper.insert_release(4_298_844)
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
    tracks = @album_release.tracks

    track = tracks[0]
    expect(track.location).to eq('A1')
    expect(track.piece_release.title).to eq('The System')
    expect(track.duration.mmss).to eq('0:23')

    track = tracks[20]
    expect(track.location).to eq('C5')
    expect(track.piece_release.title).to eq('∞')

    track = tracks[23]
    expect(track.location).to eq('D2')
    expect(track.piece_release.title).to eq('Break')
  end

  it 'has imported the identifiers' do
    identifiers = @album_release.identifiers

    identifier = identifiers[0]
    expect(identifier.type.name).to eq('Other')
    expect(identifier.disambiguation).to eq('Cat. nr. disc 1')
    expect(identifier.code).to eq('6333 500')

    identifier = identifiers[5]
    expect(identifier.type.name).to eq('Matrix / Runout')
    expect(identifier.disambiguation).to be_nil
    expect(identifier.code).to eq('Side4 - 10 AA6333501 2Y 320')
  end

  it 'has imported the labels' do
    label = @album_release.labels[0]
    expect(label.company.name).to eq('Vertigo')
    expect(label.catalog_no).to eq('6673 001')
  end

  after(:all) { DatabaseCleaner.clean }
end
