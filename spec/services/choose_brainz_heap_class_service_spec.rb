# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ChooseBrainzHeapClassService do
  it_behaves_like 'a service'

  context 'with type "Album"' do
    it 'returns "Album"' do
      expect(described_class.call(type: 'Album')).to eq('Album')
    end
  end

  context 'with type "Single"' do
    it 'returns "Single"' do
      expect(described_class.call(type: 'Single')).to eq('Single')
    end
  end

  context 'with another type' do
    it 'returns the default: "Heap"' do
      expect(described_class.call(type: 'SomeType')).to eq('Heap')
    end
  end
end
