# frozen_string_literal: true

require 'rails_helper'

# ImportOrder for testing
class DummyImportOrder < ImportOrder; end

RSpec.describe BaseImportWorker do
  context 'with an appropriate queued ImportOrder' do
    before do
      DatabaseCleaner.start
    end

    after { DatabaseCleaner.clean }

    let!(:import_order) do
      DummyImportOrder.create!(
        code: '123',
        kind: 'some-kind',
        user: FactoryBot.create(:user)
      )
    end

    it 'calls #run on the root-importer' do
      importer = spy
      described_class.run(
        importer:           importer,
        import_order_class: 'DummyImportOrder'
      )
      expect(importer).to have_received(:run).with(import_order)
    end
  end
end
