require 'rails_helper'
require 'ko_test_data'

RSpec.describe MashedBrainz::UrlRels do
  let(:url_rels) do
    reference = BrainzReleaseGroupRef.new(
      code: '7d31891f-b9da-36de-ab08-98b1fdbbb023'
    )
    release_group = MashedBrainz.from_xml(
      KoTestData.brainz_xml_for(reference)
    )
    release_group.relation_list_for(:url)
  end

  context 'with a discogs url' do
    specify '#discogs' do
      expect(url_rels.discogs).to be_instance_of(MashedBrainz::Relation)
    end

    specify '#discogs_code' do
      expect(url_rels.discogs_code).to eq('32000')
    end

    specify '#discogs_url' do
      expect(url_rels.discogs_url).to eq('https://www.discogs.com/master/32000')
    end
  end

  describe '#wikidata_code' do
    it 'returns the wikidata code'
  end
end
