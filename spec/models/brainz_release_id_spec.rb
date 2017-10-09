require 'rails_helper'

RSpec.describe BrainzReleaseId do
  before(:each) do
    @brainz_id = FactoryGirl.build(:brainz_release_id)
  end

  it 'returns the source_id' do
    source_id = @brainz_id.source_id
    expect(source_id)
      .to match(%r{^https://musicbrainz.org/ws/2/release/})
    expect(source_id)
      .to match(/\?inc=artists\+labels\+recordings\+release-groups$/)
  end
end
