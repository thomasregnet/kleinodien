require 'rails_helper'
require 'ko_test_data'
RSpec.describe MashedBrainz::ReleaseGroup do
  before(:each) do
    foreign_id = BrainzReleaseGroupRef.new(
      code: '7d31891f-b9da-36de-ab08-98b1fdbbb023'
    )
    @orig_release_group = MashedBrainz::ReleaseGroup.xml(
      KoTestData.brainz_xml_for(foreign_id)
    )
  end

  specify '#foreign_id' do
    expect(@orig_release_group.brainz_id)
      .to be_instance_of(BrainzReleaseGroupRef)
  end

  it '#title' do
    expect(@orig_release_group.title)
      .to eq 'The Sky Is Falling and I Want My Mommy'
  end
end
