# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# For testing
class TestImportClass
end

RSpec.describe ImportBrainzRelease do
  it_behaves_like 'a service'

  context 'when it is called with an object of the wrong class' do
    it 'raises without a BrainzImportOrder' do
      expect { described_class.call(TestImportClass.new) }
        .to raise_error ArgumentError
    end
  end

  context 'when the kind is wrong' do
    let(:import_order) do
      FactoryBot.build(:brainz_import_order, kind: 'artist')
    end

    it 'raises if the kind is not "release"' do
      expect { described_class.call(import_order) }
        .to raise_error ArgumentError
    end
  end

  it 'initializes the store'

  it 'calls PrepareBrainzRelease' do
    allow(PrepareBrainzRelease).to receive(:call)
    described_class.call(
      FactoryBot.build(:brainz_import_order, kind: 'release')
    )
  end

  it 'calls PersistBrainzRelease'

  it 'persists within a transaction'
end
