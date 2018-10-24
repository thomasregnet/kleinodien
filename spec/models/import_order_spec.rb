require 'rails_helper'

RSpec.describe ImportOrder, type: :model do
  context 'only called with an uri' do
    let(:user) { FactoryBot.create(:user) }
    def expected_code
      '57961a97-3796-4bf7-9f02-a985a8979ae9'
    end

    def expected_kind
      'artist'
    end

    def expected_type
      'MusicBrainzImportOrder'
    end

    def uri_string
      ['https://musicbrainz.org', expected_kind, expected_code].join('/')
    end

    let(:order) { described_class.new(uri: uri_string, user: user) }

    it 'has the expected code set' do
      expect(order.code).to eq expected_code
    end

    it 'has the expected kind set' do
      expect(order.kind).to eq expected_kind
    end

    it 'has the expected type set' do
      expect(order.type).to eq expected_type
    end

    it 'can be saved' do
      expect(order.save).to be true
    end
  end
end
