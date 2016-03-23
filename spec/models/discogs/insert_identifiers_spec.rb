require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertIdentifiers, type: :model do
  context 'Dead Human Collection' do
    before(:all) do
      DatabaseCleaner.start

      json = DiscogsTestHelper.get_discogs_data('releases', 4_462_260)
      dc_release = KleinodienDiscogs.get_release(json)
      @album_release = FactoryGirl.create(:album_release)
      Discogs::InsertIdentifiers.perform(dc_release.identifiers, @album_release)
      @identifiers = @album_release.identifiers
    end

    # TODO: spec for nil identifiers
    it 'has set the identifiers' do
      identifier = @identifiers[0]
      expect(identifier.type.name).to eq('Barcode')
      expect(identifier.code).to eq('039841518009')

      identifier = @identifiers[1]
      expect(identifier.type.name).to eq('Matrix / Runout')
      expect(identifier.code).to eq('Sony DADC A0102100183-0104 13 A00')
      expect(identifier.disambiguation).to eq('CD 1')

      identifier = @identifiers[15]
      expect(identifier.type.name).to eq('Label Code')
      expect(identifier.code).to eq('LC6705')
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
