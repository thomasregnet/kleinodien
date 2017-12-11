require 'rails_helper'

RSpec.describe BrainzReference do
  let(:brainz) do
    described_class.from_code('07ba5f4d-af2e-4c17-8901-79fa2d5bcfa9')
  end

  describe '#host' do
    it 'returns the default host' do
      expect(brainz.host).to eq('musicbrainz.org')
    end
  end

  describe '#path_prefix' do
    it 'returns the path_prefix' do
      expect(brainz.path_prefix).to eq('ws/2')
    end
  end

  describe 'scheme' do
    it 'returns the scheme' do
      expect(brainz.scheme).to eq('https')
    end
  end
end
