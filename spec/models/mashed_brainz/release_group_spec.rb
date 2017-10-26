require 'rails_helper'
require 'ko_test_data'
RSpec.describe MashedBrainz::ReleaseGroup do
  before(:each) do
    foreign_id = BrainzReleaseGroupId.new(
      value: '7d31891f-b9da-36de-ab08-98b1fdbbb023'
    )
    @orig_release_group = MashedBrainz::ReleaseGroup.xml(
      KoTestData.brainz_xml_for(foreign_id)
    )
  end

  it 'returns the foreign_id' do
    expect(@orig_release_group.brainz_id)
      .to be_instance_of(BrainzReleaseGroupId)
  end
end
