require 'rails_helper'

RSpec.describe BrainzReleaseId do
  def prefix_regex
    %r{^https://musicbrainz.org/ws/2/release/}
  end

  def query_string_regex
    /\?inc=artists\+labels\+recordings\+release-groups$/
  end

  before(:each) do
    @brainz_id = FactoryGirl.build(:brainz_release_id)
  end

  specify '.source_id' do
    source_id = BrainzReleaseId.source_id(SecureRandom.uuid)
    expect(source_id).to match(prefix_regex)
    expect(source_id).to match(query_string_regex)
  end

  specify '#source_id' do
    source_id = @brainz_id.source_id
    expect(source_id).to match(prefix_regex)
    expect(source_id).to match(query_string_regex)
  end
end
