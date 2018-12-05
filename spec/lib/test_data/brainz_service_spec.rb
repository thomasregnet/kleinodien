# frozen_string_literal: true

require 'rails_helper'
require 'test_data/brainz_service'

RSpec.describe TestData::BrainzService do
  describe '.blueprint' do
    it 'returns a BrainzBlueprint' do
      code = 'bdacc37b-8633-4bf8-9dd5-4662ee651aec'
      expect(described_class.blueprint(:artist, code))
        .to be_instance_of(BrainzBlueprint)
    end

    it 'adds #raw_data to the blueprint' do
      code = 'bdacc37b-8633-4bf8-9dd5-4662ee651aec'

      expect(described_class.blueprint(:artist, code).raw_data)
        .to match(/\A<\?xml/)
    end
  end
end
