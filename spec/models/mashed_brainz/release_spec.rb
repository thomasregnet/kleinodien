require 'rails_helper'
require 'brainz_test_helper'

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
    # byebug
    expect(@release.artist_credit)
      .to be_instance_of MashedBrainz::ArtistCredit
  end

  specify '#brainz_id' do
    expect(@release.brainz_id).to be_instance_of(BrainzReleaseId)
  end

  specify '#source_id' do
    # TODO: Better expectation
    expect(@release.source_id).to be_instance_of(String)
  end
end
