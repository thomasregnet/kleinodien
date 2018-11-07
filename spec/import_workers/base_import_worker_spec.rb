# frozen_string_literal: true

require 'rails_helper'

# ImportOrder for testing
class DummyImportOrder < ImportOrder; end

# Overwrite some methods for testing
class TestImportWorker < BaseImportWorker
  def initialize(args)
    @subscribe_spy   = args[:subscribe_spy]
    @unsubscribe_spy = args[:unsubscribe_spy]
    super(args)
  end

  attr_reader :subscribe_spy, :unsubscribe_spy

  def subscribe
    subscribe_spy.called(true)
  end

  def unsubscribe
    unsubscribe_spy.called(true)
  end
end

RSpec.describe BaseImportWorker do
  let(:worker) do
    worker = TestImportWorker.new(
      importer:           spy,
      import_order_class: 'DummyImportOrder',
      subscribe_spy:      spy,
      unsubscribe_spy:    spy
    )
    worker.run
    worker
  end

  context 'with an appropriate ImportOrder' do
    before(:all) do
      DatabaseCleaner.start
      @import_order = DummyImportOrder.create!(
        code: '123',
        kind: 'some-kind',
        user: FactoryBot.create(:user)
      )
    end

    after(:all) { DatabaseCleaner.clean }

    it 'calls #unsubscribe' do
      expect(worker.unsubscribe_spy).to have_received(:called).with(true)
    end
    it 'calls #run on the root-importer' do
      expect(worker.importer).to have_received(:run).with(@import_order)
    end

    it 'subscribes when there are no more pending orders' do
      expect(worker.subscribe_spy).to have_received(:called).with(true)
    end
  end

  context 'without an appropriate ImportOrderder' do
    # it 'subscribes to the import triggers' do
    it 'does not call #run on the importer' do
      expect(worker.importer).not_to have_received(:run)
    end

    it 'does not call #unsubscribe' do
      expect(worker.unsubscribe_spy).not_to have_received(:called)
    end

    it 'subscribes' do
      expect(worker.subscribe_spy).to have_received(:called).with(true)
    end
  end
end
