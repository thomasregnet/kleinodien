# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

RSpec.describe PersistBrainzHeapMedia do
  # TODO: do this with a double album
  describe '.call' do
    let(:blueprint) do
      TestData.by_name(:brainz_release_powerslave_enhanced_cd)
              .blueprint.media
    end

    let(:heap) { FactoryBot.create(:heap) }
    let(:import_order) { FactoryBot.create(:brainz_import_order) }

    it 'returns the created entries' do
      args = {
        blueprint:    blueprint,
        heap:         heap,
        import_order: import_order
      }
      described_class.call(args)
      expect(heap.media[0].format.name).to eq('Enhanced CD')
    end
  end
end
