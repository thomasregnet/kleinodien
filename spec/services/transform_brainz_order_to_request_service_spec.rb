# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe TransformBrainzOrderToRequestService do
  it_behaves_like 'a service'

  # the specs for the service belongs here

  it 'raises with a wrong ImportOrder class'

  context 'when the kind is "release"' do
    it 'returns a BrainzReleaseImportRequest object'
  end
end
