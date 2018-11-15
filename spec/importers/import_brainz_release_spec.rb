# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# For testing
class TestImportClass
end

class MockImportBrainzReleasePrepareAndPersist
  def initialize
  end
end

RSpec.describe ImportBrainzRelease do
  it_behaves_like 'a service'

  def brainz_code
    'ad6f9162-e8b2-11e8-8a59-abffd0f2862f'
  end

  context 'when the requested import already exists' do
    before do
      DatabaseCleaner.start
      FactoryBot.create(:compilation_release, brainz_code: brainz_code)
    end

    after { DatabaseCleaner.clean }

    let(:import_order) do
      FactoryBot.build(
        :brainz_import_order,
        code: brainz_code,
        kind:        :release
      )
    end

    specify 'the :result contains the release' do
      expect(described_class.call(import_order)[:result])
        .to be_instance_of CompilationRelease
    end

    specify ':new_record is false' do
      expect(described_class.call(import_order)[:new_record])
        .to be false
    end
  end

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
