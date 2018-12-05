# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data/brainz_service'

RSpec.describe TestData::BrainzService do
  it_behaves_like 'a service'

  describe '.call' do
    it 'returns a BrainzBlueprint' do
      # code = 'bdacc37b-8633-4bf8-9dd5-4662ee651aec'
      args = {
        code: 'bdacc37b-8633-4bf8-9dd5-4662ee651aec',
        kind: :artist
      }
      expect(described_class.call(args))
        .to be_instance_of(TestData::BrainzResult)
    end
  end
end
