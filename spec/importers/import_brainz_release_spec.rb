# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# For testing
class TestImportClass
end

# Mock #persist and #prepare
class MockImportBrainzReleasePersistAndPrepare < ImportBrainzRelease
  def self.call(args)
    me = new(args[:import_order])
    me.init_spies(args)
    me.call
  end

  def init_spies(args)
    @persist_spy = args[:persist_spy]
    @prepare_spy = args[:prepare_spy]
  end

  attr_reader :persist_spy, :prepare_spy

  def persist
    return unless persist_spy

    persist_spy.called
  end

  def prepare
    return unless prepare_spy

    prepare_spy.called
  end
end

# rubocop:disable Metrics/BlockLength
RSpec.describe ImportBrainzRelease do
  it_behaves_like 'a service'

  def brainz_code
    'ad6f9162-e8b2-11e8-8a59-abffd0f2862f'
  end

  def import_order_args
    { code: brainz_code, kind: :release }
  end

  context 'when the requested import already exists' do
    before do
      DatabaseCleaner.start
      FactoryBot.create(:compilation_release, brainz_code: brainz_code)
    end

    after { DatabaseCleaner.clean }

    let(:import_order) do
      FactoryBot.build(:brainz_import_order,  import_order_args)
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

  # it 'calls PrepareBrainzRelease' do
  #   allow(PrepareBrainzRelease).to receive(:call)
  #   described_class.call(
  #     FactoryBot.build(:brainz_import_order, kind: 'release')
  #   )
  # end

  describe 'when the release does not exist' do
    let(:import_order) do
      FactoryBot.build(:brainz_import_order, import_order_args)
    end

    it 'calls #persist' do
      persist_spy = spy
      MockImportBrainzReleasePersistAndPrepare.call(
        expected_kind: :release,
        import_order:  import_order,
        persist_spy:   persist_spy
      )
      expect(persist_spy).to have_received(:called)
    end

    it 'calls #prepare' do
      prepare_spy = spy
      MockImportBrainzReleasePersistAndPrepare.call(
        import_order:  import_order,
        expected_kind: :release,
        prepare_spy:   prepare_spy
      )
      expect(prepare_spy).to have_received(:called)
    end
  end

  it 'persists within a transaction'
end
# rubocop:enable Metrics/BlockLength
