require 'rails_helper'
require 'brainz_test_helper'

RSpec.describe Import::BrainzRelease, type: :model do
  before(:each) do
    @xml = BrainzTestHelper.get_xml(
      :release,
      '28e723f2-1c0a-38a0-8109-038cca05ffca'
    )
  end

  it 'returns xml' do
    expect(Import::BrainzRelease.perform(@xml))
      .to match(/^<\?xml/)
  end
end
