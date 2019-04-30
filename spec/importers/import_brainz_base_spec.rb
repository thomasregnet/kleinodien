# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportBrainzBase do
  describe '#proxy' do
    let(:importer) { described_class.new({}) }

    it 'returns a BrainzProxy' do
      expect(importer.proxy).to be_instance_of(BrainzProxy)
    end
  end
end
