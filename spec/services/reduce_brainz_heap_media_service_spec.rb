# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe ReduceBrainzHeapMediaService do
  it_behaves_like 'a service'

  # TODO: do this with a double album
  describe '.call' do
    let(:blueprint) do
      TestData.by_name(:brainz_release_powerslave_enhanced_cd)
              .blueprint.media
    end

    # let(:heap) { FactoryBot.create(:heap) }
    let(:import_order) { FactoryBot.create(:brainz_import_order) }

    it 'returns the created entries' do
      args = {
        blueprint:    blueprint,
        import_order: import_order
      }
      # described_class.call(args)
      # expect(heap.media[0].format.name).to eq('Enhanced CD')
      expect(described_class.call(args).first.name)
        .to eq('Enhanced CD')
    end
  end
end
