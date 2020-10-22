# frozen_string_literal: true

require 'mock_import_order'
require 'rails_helper'

RSpec.describe BrainzProxy do
  def brainz_code
    '37e9d7b2-7779-41b2-b2eb-3685351caad3' # NoMeansNo
  end

  # This method smells of :reek:UtilityFunction
  def import_order
    FactoryBot.create(:brainz_import_order)
  end

  let(:proxy) { described_class.new(import_order: import_order) }

  describe '#cached?' do
    context 'when cached' do
      it 'returns true' do
        allow(proxy).to receive(:cache).and_return('test' => 'data')
        allow(proxy).to receive(:uri_for).and_return('test')

        expect(proxy).to be_cached(:something, 'test')
      end
    end

    context 'when not cached' do
      it 'returns false' do
        expect(proxy)
          .not_to be_cached(:artist, '50c636c5-c1cc-461f-88ec-1df95fddb9da')
      end
    end
  end

  describe '.last_request' do
    it 'is initial set to 0' do
      expect(described_class.last_request).to be(0)
    end
  end

  describe '#last_request' do
    it 'is initial set to 0' do
      expect(proxy.last_request).to be(0)
    end
  end

  describe '#get' do
    it 'returns a Brainz blueprint' do
      expect(proxy.get(:artist, brainz_code)).to be_instance_of BrainzBlueprint
    end
  end

  context 'with an ImportOrder missmatch' do
    let(:proxy) { described_class.new(import_order: import_order) }
    let(:import_request) { FactoryBot.build(:brainz_artist_import_request) }

    it 'raises an ArgumentError' do
      expect { proxy.get(import_request) }.to raise_error ArgumentError
    end
  end

  context 'when locked' do
    describe '#locked?' do
      let(:proxy) do
        described_class.new(
          import_order: FactoryBot.create(:brainz_import_order)
        )
      end

      it 'return true' do
        proxy.lock
        expect(proxy.locked?).to be true
      end
    end

    describe '#get' do
      let(:proxy) do
        described_class.new(import_order: FactoryBot.create(:import_order))
      end

      it 'raises an error if the ImportRequest is not cached' do
        proxy.lock
        expect { proxy.get(:artist, brainz_code) }
          .to raise_error ImportError::ProxyLocked
      end
    end
  end
end
