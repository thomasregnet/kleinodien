require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertExtraartists, type: :model do
  context 'AC/DC - Highway To Hell' do
    before(:all) do
      DatabaseCleaner.start
      
      json = DiscogsTestHelper.get_discogs_data('releases', 940468)
      dc_release = KleinodienDiscogs.get_release(json)
      @release = Discogs::InsertRelease.perform(dc_release)
      @credits = @release.credits
    end

    it 'has the extraartists set' do
      credit = @credits[0]
      expect(credit.artist_credit.name).to eq('Cliff Williams')
      expect(credit.job.name).to eq('Bass')
      
      credit = @credits[3]
      expect(credit.artist_credit.name).to eq('Angus Young')
      expect(credit.job.name).to eq('Guitar')

      credit = @credits[8]
      expect(credit.artist_credit.name).to eq('Bon Scott')
      expect(credit.job.name).to eq('Vocals')

      credit = @credits[9]
      expect(credit.artist_credit.name).to eq('Angus Young')
      expect(credit.job.name).to eq('Written-By')
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
