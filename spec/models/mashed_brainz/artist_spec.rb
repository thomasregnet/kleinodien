require 'rails_helper'
require 'brainz_test_helper'
require 'shared_examples_for_brainz_artist_source_id'

RSpec.describe MashedBrainz::Artist, type: :model do
  before(:each) do
    xml = BrainzTestHelper.get_xml(
      :release,
      '28e723f2-1c0a-38a0-8109-038cca05ffca'
    )
    multi_xml = MultiXml.parse(xml)
    release = MashedBrainz::Release.new(multi_xml['metadata']['release'])
    @artist = release.artist_credit.name_credit[0].artist
  end

  describe '#brainz_id' do
    it_behaves_like 'a brainz artist source id' do
      let(:source_id) { @artist.brainz_id.source_id }
    end
  end

  describe '#source_id' do
    it_behaves_like 'a brainz artist source id' do
      let(:source_id) { @artist.source_id }
    end
  end
end
