# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'ko_test_data'

RSpec.describe PrepareBrainzArtistCredit do
  it_behaves_like 'a service'

  # TODO: Add some specs to PrepareBrainzArtistCredit
  describe '.call' do
    let(:blueprint) do
      xml_string = KoTestData::GetBrainzXmlFor.path(
        'release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4a' \
          '?inc=artists+labels+recordings+release-groups.xml'
      )
      BrainzBlueprint.from_xml(xml_string).artist_credit
    end

    let(:artist_blueprint) do
      xml_string = KoTestData::GetBrainzXmlFor.path(
        'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
      )
      BrainzBlueprint.from_xml(xml_string)
    end

    it 'requests the artist' do
      proxy = double # spy
      args  = { blueprint: blueprint, proxy: proxy }
      allow(proxy).to receive(:get).and_return(artist_blueprint)

      expect(described_class.call(args)).to be_nil
    end
  end
end
