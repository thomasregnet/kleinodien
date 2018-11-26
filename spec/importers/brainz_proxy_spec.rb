# frozen_string_literal: true

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
  let(:import_request) do
    FactoryBot.build(
      :brainz_artist_import_request,
      code: brainz_code,
      import_order: nil
    )
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
      expect(proxy.get(import_request)).to be_instance_of BrainzBlueprint
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
      let(:proxy) { described_class.new({}) }

      it 'return true' do
        proxy.lock
        expect(proxy.locked?).to be true
      end
    end

    describe '#get' do
      def import_request
        @import_request ||= FactoryBot.create(:brainz_artist_import_request)
      end

      let(:proxy) do
        described_class.new(import_order: import_request.import_order)
      end

      it 'raises an error if the ImportRequest is not cached' do
        proxy.lock
        expect { proxy.get(import_request) }
          .to raise_error ImportError::ProxyLocked
      end
    end
  end
end
