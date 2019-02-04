# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

class WrongImportOrder
  def valid?
    true
  end
end

RSpec.describe TransformBrainzOrderToRequestService do
  it_behaves_like 'a service'

  # the specs for the service belongs here

  context 'with a wrong ImportOrder-class' do
    # let(:args) { { import_order: TestWrongImportOrder.new } }
    let(:wrong_import_order) { WrongImportOrder.new }

    it 'raises an ArgumentError' do
      expect { described_class.call(import_order: wrong_import_order) }
        .to raise_error ArgumentError
    end
  end

  context 'with ImporOrder#kind "release"' do
    let(:import_order) do
      FactoryBot.build(:brainz_import_order, kind: 'release')
    end

    it 'returns a BrainzReleaseImportRequest object' do
      expect(described_class.call(import_order: import_order))
        .to be_instance_of BrainzReleaseImportRequest
    end
  end
end
