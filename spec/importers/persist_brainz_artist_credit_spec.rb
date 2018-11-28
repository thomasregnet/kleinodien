# frozen_string_literal: true

require 'ko_test_data'
require 'rails_helper'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
RSpec.describe PersistBrainzArtistCredit do
  it_behaves_like 'a service'

  context 'when the ArtistCredit already exists' do
    describe '.call' do
      let!(:artist_credit) do
        FactoryBot.create(:artist_credit, name: 'Jello Biafra With NoMeansNo')
      end

      let(:blueprint) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'release/693748be-7c18-39c3-af2e-2e62092090cf?' \
            'inc=artists+labels+recordings+release-groups.xml'
        )
        BrainzBlueprint.from_xml(xml_string).artist_credit
      end

      it 'returns the ArtistCredit' do
        expect(described_class.call(blueprint: blueprint))
          .to eq(artist_credit)
      end
    end
  end

  context 'when the ArtistCredit is not persisted' do
    describe '.call' do
      let(:blueprint) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'release/693748be-7c18-39c3-af2e-2e62092090cf?' \
            'inc=artists+labels+recordings+release-groups.xml'
        )
        BrainzBlueprint.from_xml(xml_string).artist_credit
      end

      let(:jello_biafra) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'artist/2280ca0e-6968-4349-8c36-cb0cbd6ee95f?inc=url-rels.xml'
        )
        BrainzBlueprint.from_xml(xml_string)
      end

      let(:nomeansno) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'artist/37e9d7b2-7779-41b2-b2eb-3685351caad3?inc=url-rels.xml'
        )
        BrainzBlueprint.from_xml(xml_string)
      end

      # rubocop:disable RSpec/MultipleExpectations
      # rubocop:disable RSpec/MessageSpies
      it 'returns the ArtistCredit' do
        proxy = spy
        expect(proxy).to receive(:get).and_return(jello_biafra)
        expect(proxy).to receive(:get).and_return(nomeansno)

        expect(described_class.call(blueprint: blueprint, proxy: proxy))
          .to be_instance_of(ArtistCredit)
      end
      # rubocop:enable RSpec/MessageSpies
      # rubocop:enable RSpec/MultipleExpectations
    end
  end
end
# rubocop:enable Metrics/BlockLength
