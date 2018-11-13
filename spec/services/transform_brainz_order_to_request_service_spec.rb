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
    let(:import_order) do
      FactoryBot.build(:brainz_import_order, kind: 'release')
    end

    it 'returns a BrainzReleaseImportRequest object' do
      expect(described_class.call(import_order))
        .to be_instance_of BrainzReleaseImportRequest
    end
  end
end
