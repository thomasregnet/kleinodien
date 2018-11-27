# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'ko_test_data'

RSpec.describe JoinBrainzArtistCreditService do
  it_behaves_like 'a service'

  context 'with more than one artist' do
    let(:name_credits) do
      xml_string = KoTestData::GetBrainzXmlFor.path(
        'release/693748be-7c18-39c3-af2e-2e62092090cf' \
          '?inc=artists+labels+recordings+release-groups.xml'
      )
      BrainzBlueprint.from_xml(xml_string).artist_credit.name_credits
    end

    it 'returns the joined artist names' do
      expect(described_class.call(name_credits: name_credits))
        .to eq('Jello Biafra With NoMeansNo')
    end
  end

  context 'with one artist' do
    let(:name_credits) do
      xml_string = KoTestData::GetBrainzXmlFor.path(
        'release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4a' \
          '?inc=artists+labels+recordings+release-groups.xml'
      )
      BrainzBlueprint.from_xml(xml_string).artist_credit.name_credits
    end

    it 'returns the artist' do
      expect(described_class.call(name_credits: name_credits))
        .to eq('Sepultura')
    end
  end
end
