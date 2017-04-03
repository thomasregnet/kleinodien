require 'rails_helper'
require 'brainz_test_helper'

RSpec.describe Import::BrainzRelease, type: :model do
  before(:each) do
    DatabaseCleaner.start
    @xml = BrainzTestHelper.get_xml(
      :release,
      '28e723f2-1c0a-38a0-8109-038cca05ffca'
    )
  end

  it 'returns an ArtistCredit' do
    artist_credit = Import::BrainzRelease.perform(@xml)
    expect(artist_credit).to be_instance_of ArtistCredit
  end

  after(:each) do
    DatabaseCleaner.clean
  end
end
