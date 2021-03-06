# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ChooseBrainzReleaseTypeService do
  it_behaves_like 'a service'

  context 'with type "Album"' do
    it 'returns "Album"' do
      expect(described_class.call(brainz_type: 'Album')).to eq('Album')
    end
  end

  context 'with type "Single"' do
    it 'returns "Single"' do
      expect(described_class.call(brainz_type: 'Single')).to eq('Single')
    end
  end

  context 'with another type' do
    it 'returns the default: "Release"' do
      expect(described_class.call(brainz_type: 'SomeType')).to eq('Release')
    end
  end
end
