require 'rails_helper'
require 'fake_reference'

RSpec.describe Importer::PrepareRawData do
  context 'with a  Brainz reference' do
    reference = BrainzReleaseReference.from_code(
      '693748be-7c18-39c3-af2e-2e62092090cf'
    )
    let(:xml_data) { TestData.fetch(reference) }

    describe '.perform' do
      it 'returns the prepared data' do
        expect(described_class.perform(reference, xml_data))
          .to be_instance_of(BrainzReleaseBlueprint)
      end
    end
  end

  context 'with a reference containing an unknown catagory' do
    describe '.perform' do
      let(:reference) { FakeReference.new(code: '13') }

      it 'raises an error' do
        expect { described_class.perform(reference, 'fake data') }
          .to raise_error(/can't prepare data for/)
      end
    end
  end
end
