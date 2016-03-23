require 'rails_helper'
require 'discogs_test_helper'
require 'shared_examples_for_album_releases_imported_from_discogs'

RSpec.describe 'Jello Biafra With Nomeansno from Discogs' do
  before(:all) do
    DatabaseCleaner.start

    @album_release = DiscogsTestHelper.insert_release(1_083_888)
    @participants  = @album_release.head.artist_credit.participants
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

  describe '#participants' do
    context 'first' do
      specify '#join_phrase' do
        expect(@participants.first.join_phrase).to eq('With')
      end

      specify '#name' do
        expect(@participants.first.artist.name).to eq('Jello Biafra')
      end
    end

    context 'last' do
      specify '#join_phrase' do
        expect(@participants.last.join_phrase).to be nil
      end

      specify '#name' do
        expect(@participants.last.artist.name).to eq('Nomeansno')
      end
    end
  end

  it 'has imported the tracks' do
    tracks = @album_release.tracks
    expect(tracks.length).to eq(8)

    track = tracks[0]
    expect(track.release.title)
      .to eq('The Sky Is Falling, And I Want My Mommy (Falling Space Junk)')
    expect(track.position).to eq('1')

    track = tracks[5]
    expect(track.release.title).to eq('Chew')
    expect(track.position).to eq('6')

    track = tracks[7]
    expect(track.release.title).to eq("The Myth Is Real - Let's Eat")
    expect(track.position).to eq('8')
  end

  it 'has imported the labels' do
    labels = @album_release.labels
    expect(labels.length).to eq(1)

    label = labels[0]
    expect(label.company.name).to eq('Alternative Tentacles')
    expect(label.catalog_no).to eq('VIRUS 85CD')
  end

  after(:all) { DatabaseCleaner.clean }
end
