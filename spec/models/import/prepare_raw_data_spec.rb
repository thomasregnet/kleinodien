require 'rails_helper'

RSpec.describe Import::PrepareRawData do
  context 'with a  Brainz reference' do
    reference = BrainzReleaseReference.from_code(
      '693748be-7c18-39c3-af2e-2e62092090cf'
    )
    let(:xml_data) { TestData.fetch(reference) }

    describe '.perform' do
      it 'returns the prepared data' do
        expect(described_class.perform(reference, xml_data))
          .to be_instance_of(Hashie::Mash)
      end
    end
  end
end
