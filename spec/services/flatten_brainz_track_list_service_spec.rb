# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe FlattenBrainzTrackListService do
  it_behaves_like 'a service'

  context 'when the track-list contains data-tracks' do
    describe '.call' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_powerslave_enhanced_cd)
                .blueprint.media[0]
      end

      it 'returns the flat tracklist' do
        expect(described_class.call(blueprint: blueprint).length).to eq(10)
      end
    end
  end

  context 'when the track-list does not contain data-tracks' do
    describe '.call' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_arise_jp_cd)
                .blueprint.media[0]
      end

      it 'returns the flat tracklist' do
        expect(described_class.call(blueprint: blueprint).length).to eq(3)
      end
    end
  end
end
