# frozen_string_literal: true

require 'ko_test_data'
require 'rails_helper'
require 'shared_examples_for_services'

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
end
