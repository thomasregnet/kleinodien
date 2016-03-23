require 'rails_helper'
require 'discogs_test_helper'

RSpec.describe Discogs::InsertFormats, type: :model do
  context 'Dead Human Collection' do
    before(:all) do
      DatabaseCleaner.start

      json = DiscogsTestHelper.get_discogs_data('releases', 4_462_260)
      dc_release = KleinodienDiscogs.get_release(json)
      # TODO: mock @album_release
      @album_release = Discogs::InsertRelease.perform(dc_release)
      @formats = @album_release.formats
    end

    it 'has the formats set' do
      format = @formats[0]
      expect(format.kind.name).to eq('All Media')
      expect(format.note).to eq('Hardcover-Artbook')
      expect(format.quantity).to eq(1)
      expect(format.details[0].kind.name).to eq('Limited Edition')

      format = @formats[1]
      expect(format.kind.name).to eq('CD')
      expect(format.quantity).to eq(3)
      expect(format.details[0].kind.name).to eq('Compilation')

      format = @formats[2]
      expect(format.kind.name).to eq('CD')
      expect(format.note).to eq('Live')
      expect(format.quantity).to eq(1)
      expect(format.details[0].kind.name).to eq('Album')

      format = @formats[3]
      expect(format.kind.name).to eq('Vinyl')
      expect(format.note).to eq('Live')
      expect(format.quantity).to eq(1)
      details = format.details
      expect(details[0].kind.name).to eq('12"')
      expect(details[1].kind.name).to eq('Picture Disc')
      expect(details[2].kind.name).to eq('Album')
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
