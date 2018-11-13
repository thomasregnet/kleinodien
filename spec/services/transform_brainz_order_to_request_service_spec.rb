# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

class TestWrongImportOrder
end
RSpec.describe TransformBrainzOrderToRequestService do
  it_behaves_like 'a service'

  # the specs for the service belongs here

  it 'raises with a wrong ImportOrder class' do
    expect { described_class.call(TestWrongImportOrder.new) }
      .to raise_error ArgumentError
  end

  context 'when the kind is "release"' do
    it 'returns a BrainzReleaseImportRequest object'
  end
end
