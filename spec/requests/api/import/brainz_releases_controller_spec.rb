require 'rails_helper'
require 'api_helper'
require 'brainz_test_helper'

RSpec.describe Api::Import::BrainzReleasesController, type: :request do
  before(:each) do
    DatabaseCleaner.start
    @xml = BrainzTestHelper.get_xml(
      :release,
      '28e723f2-1c0a-38a0-8109-038cca05ffca'
    )
  end

  it 'takes an MusicBrainz release' do
    post(
      '/api/import/brainz_releases',
      headers: { 'Content-Type' => 'application/json' },
      params:  { data: @xml }.to_json
    )

    expect(response).to be_success
  end

  after(:each) do
    DatabaseCleaner.clean
  end
end
