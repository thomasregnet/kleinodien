# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ChooseBrainzHeapHeadClassService do
  it_behaves_like 'a service'
  context 'with type "Album"' do

    it 'returns "AlbumHead"' do
      expect(described_class.call(type: 'Album')).to eq('AlbumHead')
    end
  end

  context 'with type "Single' do
    it 'returns "SingleHead"' do
      expect(described_class.call(type: 'Single')).to eq('SingleHead')
    end
  end

  context 'with another type' do
    it 'returns the default: "HeapHead"' do
      expect(described_class.call(type: 'SomeType')).to eq('HeapHead')
    end
  end
end
