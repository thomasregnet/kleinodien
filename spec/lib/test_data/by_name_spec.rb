# forzen_string_literal: true

require 'rails_helper'
require 'test_data/by_name'

RSpec.describe TestData::ByName do
  context 'with a valid name' do
    let(:name) { :brainz_arise_cd }

    it 'returns a TestData::BrainzResult' do
      expect(described_class.call(name))
        .to be_instance_of(TestData::BrainzResult)
    end
  end
end
