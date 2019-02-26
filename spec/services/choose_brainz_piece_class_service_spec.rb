# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ChooseBrainzPieceClassService do
  it_behaves_like 'a service'

  context 'when the recording has set video to "true"' do
    let(:blueprint) do
      Hashie::Mash.new(video: 'true')
    end

    it 'returns "Video"' do
      expect(described_class.call(blueprint: blueprint)).to eq('Video')
    end
  end

  context 'when the recording has set video to something else' do
    let(:blueprint) do
      Hashie::Mash.new(video: 'some value')
    end

    it 'returns "Song"' do
      expect(described_class.call(blueprint: blueprint)).to eq('Song')
    end
  end

  context 'when the recording has no video at all' do
    let(:blueprint) do
      Hashie::Mash.new({})
    end

    it 'returns "Song"' do
      expect(described_class.call(blueprint: blueprint)).to eq('Song')
    end
  end
end
