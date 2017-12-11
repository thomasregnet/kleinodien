require 'rails_helper'
require 'ko_test_data'

RSpec.describe MashedBrainz::ReleaseGroup do
  before(:each) do
    reference = BrainzReleaseGroupReference.from_code(
      '7d31891f-b9da-36de-ab08-98b1fdbbb023'
    )
    @orig_release_group = MashedBrainz.from_xml(
      KoTestData.brainz_xml_for(reference)
    )
  end

  specify '#reference' do
    expect(@orig_release_group.reference)
      .to be_instance_of(BrainzReleaseGroupReference)
  end

  it '#title' do
    expect(@orig_release_group.title)
      .to eq 'The Sky Is Falling and I Want My Mommy'
  end

  describe '#relation_list_for' do
    it 'returns the relations of a given type' do
      expect(@orig_release_group.relation_list_for(:url))
        .to be_instance_of(MashedBrainz::UrlRels)
    end
  end
end
