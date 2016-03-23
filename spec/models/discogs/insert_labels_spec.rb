require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertLabels, type: :model do
  context 'AC/DC - Highway To Hell' do
    before(:all) do
      DatabaseCleaner.start

      json = DiscogsTestHelper.get_discogs_data('releases', 940_468)
      dc_release = KleinodienDiscogs.get_release(json)
      @release = Discogs::InsertRelease.perform(dc_release)
      @labels = @release.labels
    end

    it 'has the labels set' do
      expect(@labels[0].company.name).to eq('Atlantic')
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
