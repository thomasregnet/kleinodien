require 'rails_helper'
require 'ko_test_data'

RSpec.describe Persist::BrainzCompilationHead do
  before(:each) do
    @cache = Import::Cache.new 
    @brainz_id = '7d31891f-b9da-36de-ab08-98b1fdbbb023'
    @foreign_id = BrainzReleaseGroupId.new(value: @brainz_id)
  end

  it 'persists a brainz release-group' do
    artist_credit = 'fake artist credit'
    compi_head = Persist::BrainzCompilationHead.using_id(
      @foreign_id, @cache, artist_credit
    )
  end
end
