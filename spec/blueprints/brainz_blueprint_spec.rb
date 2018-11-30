# frozen_string_literal: true

require 'rails_helper'
require 'ko_test_data'

# rubocop:disable Metrics/BlockLength
RSpec.describe BrainzBlueprint do
  it '#relation_lists'
  it '#url_relations'
  it '#codes_hash'
  it 'brainz_code'

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

  describe '#join_name' do
    let(:artist_credit) do
      xml_string = KoTestData::GetBrainzXmlFor.path(
        'release/693748be-7c18-39c3-af2e-2e62092090cf?' \
          'inc=artists+labels+recordings+release-groups.xml'
      )
      described_class.from_xml(xml_string).artist_credit
    end

    it 'returns the join_name' do
      expect(artist_credit.join_name).to eq('Jello Biafra With NoMeansNo')
    end
  end

  describe '#discogs_code' do
    context 'when the blueprint contains a discogs url' do
      let(:blueprint) do
        KoTestData::GetBrainzBlueprintFor.path(
          'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
        )
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
        )
        described_class.from_xml(xml_string)
      end

      it 'returns the discogs-code' do
        expect(blueprint.discogs_code).to eq('34058')
      end
    end

    context 'when the blueprint does not contain a discogs url' do
      let(:blueprint) do
        KoTestData::GetBrainzBlueprintFor.path(
          'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
        )
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4a?'\
            'inc=artists+labels+recordings+release-groups.xml'
        )
        described_class.from_xml(xml_string)
      end

      it 'returns the discogs-code' do
        expect(blueprint.discogs_code).to be_nil
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
