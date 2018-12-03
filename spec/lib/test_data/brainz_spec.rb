require 'rails_helper'
require 'test_data/brainz'

RSpec.describe TestData::Brainz do
  describe '.blueprint' do
    it 'returns a BrainzBlueprint' do
      code = 'bdacc37b-8633-4bf8-9dd5-4662ee651aec'
      expect(described_class.blueprint(:artist, code))
        .to be_instance_of(BrainzBlueprint)
    end
  end
end
