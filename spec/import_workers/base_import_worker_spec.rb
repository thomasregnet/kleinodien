# frozen_string_literal: true

require 'rails_helper'

# ImportOrder for testing
class DummyImportOrder < ImportOrder; end

# Overwrite some methods for testing
class TestImportWorker < BaseImportWorker
  def initialize(args)
    @subscription_spy = args[:subscription_spy]
    super(args)
  end

  attr_reader :subscription_spy

  def subscribe
    subscription_spy.called(true)
  end
end

RSpec.describe BaseImportWorker do
  let(:worker) do
    importer_spy     = spy
    subscription_spy = spy
    worker = TestImportWorker.new(
      importer:           importer_spy,
      import_order_class: 'DummyImportOrder',
      subscription_spy:   subscription_spy
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

    it 'calls #run on the root-importer' do
      expect(worker.importer).to have_received(:run).with(@import_order)
    end

    it 'subscribes when there are no more pending orders' do
      expect(worker.subscription_spy).to have_received(:called).with(true)
    end
  end

  context 'without an appropriate ImportOrderder' do
    # it 'subscribes to the import triggers' do
    it 'does not call #run on the importer' do
      expect(worker.importer).not_to have_received(:run)
    end

    it 'subscribes' do
      expect(worker.subscription_spy).to have_received(:called).with(true)
    end
  end
end
