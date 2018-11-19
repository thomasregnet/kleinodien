# frozen_string_literal: true

require 'rails_helper'
require 'ko_test_data'

RSpec.describe BrainzBlueprint do
  describe '.from_xml' do
    let(:xml) do
      KoTestData::GetBrainzXmlFor.path(
        'release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4a?' \
          'inc=artists+labels+recordings+release-groups.xml'
      )
    end

    it 'returns the blueprint' do
      expect(described_class.from_xml(xml)).to be_instance_of described_class
    end
  end

  describe '#discogs_code' do
    context 'when the blueprint contains an discogs url' do
      let(:blueprint) do
        KoTestData::GetBrainzBlueprintFor.path(
          'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
        )
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
        )
        BrainzBlueprint.from_xml(xml_string)
      end

      it 'returns the discogs-code' do
        expect(blueprint.discogs_code).to eq('34058')
      end
    end
  end
end
