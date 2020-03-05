# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportBrainzBase do
  describe '#proxy' do
    let(:importer) do
      described_class.new(import_order: FactoryBot.create(:brainz_import_order))
    end

    it 'returns a BrainzProxy' do
      expect(importer.proxy).to be_instance_of(BrainzProxy)
    end
  end
end
