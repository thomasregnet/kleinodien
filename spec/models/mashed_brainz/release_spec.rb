require 'rails_helper'
require 'brainz_test_helper'
require 'shared_examples_for_brainz_release_source_id'

RSpec.describe MashedBrainz::Release, type: :model do
  before(:each) do
    xml = BrainzTestHelper.get_xml(
      :release,
      '28e723f2-1c0a-38a0-8109-038cca05ffca'
    )
    multi_xml = MultiXml.parse(xml)
    @release = MashedBrainz::Release.new(multi_xml['metadata']['release'])
  end

  specify '#artist_credit' do
    expect(@release.artist_credit)
      .to be_instance_of MashedBrainz::ArtistCredit
  end

  describe '#brainz_id' do
    it_behaves_like 'a brainz release source id' do
      let(:source_id) { @release.brainz_id.source_id }
    end
  end

  describe '#source_id' do
    it_behaves_like 'a brainz release source id' do
      let(:source_id) { @release.source_id }
    end
  end
end
