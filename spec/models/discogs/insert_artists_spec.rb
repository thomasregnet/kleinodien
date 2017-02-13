require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertArtists, type: :model do
  context 'Jello Biafra With Nomeansno' do
    before(:all) do
      DatabaseCleaner.start

      json = DiscogsTestHelper.get_discogs_data('releases', 1_083_888)
      dc_release = KleinodienDiscogs.get_release(json)
      @artist_credit = Discogs::InsertArtists.perform(dc_release.artists)
    end

    it 'has the right name set' do
      expect(@artist_credit.name).to eq('Jello Biafra With Nomeansno')
    end

    it 'has the expected joinparse' do
      expect(@artist_credit.participants[0].join_phrase).to eq('With')
    end

    specify 'first artist' do
      artist = @artist_credit.participants[0].artist
      expect(artist.name).to         eq 'Jello Biafra'
      expect(artist.identifiers.first.source.name).to  eq 'Discogs'
      expect(artist.identifiers.first.value).to eq '37752'
    end

    specify 'first artist' do
      artist = @artist_credit.participants[1].artist
      expect(artist.name).to         eq 'Nomeansno'
      expect(artist.identifiers.first.source.name).to  eq 'Discogs'
      expect(artist.identifiers.first.value).to eq '133641'
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
